(() => {
  "use strict";

  const channel = "bvnplay-runtime";
  const protocolVersion = 2;
  const releaseId = "20260711-frame-ready-v2";
  const isBvnGame = /^\/games\/bvn-[^/]+\//.test(location.pathname);
  if (!isBvnGame || window.parent === window) {
    return;
  }

  let parentOrigin = "";
  try {
    const referrer = new URL(document.referrer);
    const isProduction = referrer.hostname === "bvnplay.online" || referrer.hostname === "www.bvnplay.online";
    const isLocal = referrer.hostname === "localhost" || referrer.hostname === "127.0.0.1";
    if (isProduction || isLocal) {
      parentOrigin = referrer.origin;
    }
  } catch {}

  if (!parentOrigin) {
    return;
  }

  function emit(type, detail = {}) {
    window.parent.postMessage({ channel, protocolVersion, releaseId, type, ...detail }, parentOrigin);
  }

  const captureFps = 4;
  const sampleWidth = 96;
  const sampleHeight = 72;
  const sampleIntervalMs = 500;
  const visualDetectionTimeoutMs = 90000;
  const minMeanLuminance = 35;
  const minLuminanceDeviation = 20;
  const minEdgeRatio = 0.03;
  const maxSampleGapMs = 1500;
  const darkMeanLuminance = 24;
  const directVisibleFrameCount = 24;
  const postTransitionVisibleFrameCount = 6;
  const darkTransitionFrameCount = 2;
  let lastProgressKey = "";
  let runtimeVisible = false;
  let detectorStarted = false;

  function startVisualDetector(canvas) {
    if (detectorStarted) {
      return;
    }
    detectorStarted = true;

    if (typeof canvas.captureStream !== "function") {
      emit("visual-detector-unavailable", { reason: "capture-stream-unavailable" });
      return;
    }

    let stream;
    let sampleTimer = 0;
    let activationTimer = 0;
    let detectionTimer = 0;
    let finished = false;
    let consecutiveVisibleFrames = 0;
    let consecutiveDarkFrames = 0;
    let hasVisibleCandidate = false;
    let hasDarkTransition = false;
    let lastSampleAt = 0;
    const video = document.createElement("video");
    const sample = document.createElement("canvas");
    sample.width = sampleWidth;
    sample.height = sampleHeight;
    const context = sample.getContext("2d", { willReadFrequently: true });
    const luminance = new Uint8Array(sampleWidth * sampleHeight);

    function cleanup() {
      window.clearInterval(sampleTimer);
      window.clearTimeout(activationTimer);
      window.clearTimeout(detectionTimer);
      video.pause();
      video.srcObject = null;
      stream?.getTracks().forEach((track) => track.stop());
    }

    function unavailable(reason) {
      if (finished) {
        return;
      }
      finished = true;
      cleanup();
      emit("visual-detector-unavailable", { reason });
    }

    function sampleFrame() {
      if (finished || video.readyState < HTMLMediaElement.HAVE_CURRENT_DATA) {
        return;
      }

      try {
        const sampledAt = performance.now();
        if (lastSampleAt && sampledAt - lastSampleAt > maxSampleGapMs) {
          consecutiveVisibleFrames = 0;
          consecutiveDarkFrames = 0;
        }
        lastSampleAt = sampledAt;

        context.drawImage(video, 0, 0, sampleWidth, sampleHeight);
        const pixels = context.getImageData(0, 0, sampleWidth, sampleHeight).data;
        let total = 0;
        let totalSquared = 0;
        let edgeCount = 0;
        for (let y = 0; y < sampleHeight; y += 1) {
          for (let x = 0; x < sampleWidth; x += 1) {
            const index = y * sampleWidth + x;
            const pixel = index * 4;
            const value = (pixels[pixel] * 54 + pixels[pixel + 1] * 183 + pixels[pixel + 2] * 19) >> 8;
            luminance[index] = value;
            total += value;
            totalSquared += value * value;
            if (x > 0 && Math.abs(value - luminance[index - 1]) > 18) {
              edgeCount += 1;
            }
            if (y > 0 && Math.abs(value - luminance[index - sampleWidth]) > 18) {
              edgeCount += 1;
            }
          }
        }

        const pixelCount = luminance.length;
        const mean = total / pixelCount;
        const variance = Math.max(0, totalSquared / pixelCount - mean * mean);
        const deviation = Math.sqrt(variance);
        const possibleEdges = sampleHeight * (sampleWidth - 1) + sampleWidth * (sampleHeight - 1);
        const edgeRatio = edgeCount / possibleEdges;
        const meaningful =
          mean >= minMeanLuminance &&
          deviation >= minLuminanceDeviation &&
          edgeRatio >= minEdgeRatio;

        if (meaningful) {
          hasVisibleCandidate = true;
          consecutiveDarkFrames = 0;
          consecutiveVisibleFrames += 1;
        } else {
          consecutiveVisibleFrames = 0;
          if (hasVisibleCandidate && mean < darkMeanLuminance) {
            consecutiveDarkFrames += 1;
            if (consecutiveDarkFrames >= darkTransitionFrameCount) {
              hasDarkTransition = true;
            }
          } else {
            consecutiveDarkFrames = 0;
          }
        }

        const requiredVisibleFrames = hasDarkTransition
          ? postTransitionVisibleFrameCount
          : directVisibleFrameCount;
        if (consecutiveVisibleFrames < requiredVisibleFrames) {
          return;
        }

        finished = true;
        cleanup();
        emit("visual-ready");
      } catch {
        unavailable("frame-sampling-failed");
      }
    }

    if (!context) {
      unavailable("sampling-context-unavailable");
      return;
    }

    try {
      stream = canvas.captureStream(captureFps);
      video.muted = true;
      video.playsInline = true;
      video.srcObject = stream;
      emit("visual-detector-active");
      sampleTimer = window.setInterval(sampleFrame, sampleIntervalMs);
      activationTimer = window.setTimeout(() => unavailable("video-frame-timeout"), 5000);
      detectionTimer = window.setTimeout(() => unavailable("visual-ready-timeout"), visualDetectionTimeoutMs);
      video.addEventListener(
        "loadeddata",
        () => {
          window.clearTimeout(activationTimer);
          sampleFrame();
        },
        { once: true }
      );
      video.play().catch(() => unavailable("video-playback-failed"));
    } catch {
      unavailable("capture-stream-failed");
    }
  }

  function reportProgress() {
    const loading = document.querySelector("#loading");
    const label = document.querySelector("#label")?.textContent?.trim().toUpperCase() || "";
    const player = Array.from(document.querySelectorAll("ruffle-player, ruffle-embed, ruffle-object")).find(
      (candidate) => typeof candidate.ruffle === "function" || candidate.shadowRoot
    );
    const playerOpacity = player ? getComputedStyle(player).opacity : "0";
    const playerCanvas = player?.shadowRoot?.querySelector("canvas");

    let phase = "Loading battle data";
    let progress = 18;

    if (!player && label.includes("LOAD RUFFLE")) {
      phase = "Loading battle engine";
      progress = 24;
    } else if (loading && label.includes("LOAD PLAYER")) {
      phase = "Starting battle engine";
      progress = 68;
    } else if (loading && label.includes("LOADING")) {
      phase = "Loading fighters and stages";
      progress = 42;
    } else if (player && !loading && playerOpacity !== "1") {
      phase = "Building the arena";
      progress = 82;
    }

    const key = `${phase}:${progress}`;
    if (key !== lastProgressKey) {
      lastProgressKey = key;
      emit("progress", { phase, progress });
    }

    if (player && playerCanvas && !loading && playerOpacity === "1" && !runtimeVisible) {
      runtimeVisible = true;
      emit("progress", { phase: "Preparing first frame", progress: 90 });
      emit("runtime-visible");
      window.clearInterval(progressTimer);
      startVisualDetector(playerCanvas);
    }
  }

  emit("progress", { phase: "Opening arena", progress: 10 });
  const progressTimer = window.setInterval(reportProgress, 250);
  document.addEventListener("DOMContentLoaded", reportProgress);
  reportProgress();
})();
(() => {
  "use strict";

  const blocked = [];
  const transparentPixel =
    "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==";
  const blankSwfUrl = new URL("../../blank-ad.swf", location.href).href;
  const emptyScriptUrl = new URL("../../blocked-runtime-request.js", location.href).href;
  const emptyResponseUrl = new URL("../../blocked-runtime-request.txt", location.href).href;

  const csp = document.createElement("meta");
  csp.httpEquiv = "Content-Security-Policy";
  csp.content = [
    "default-src 'self' data: blob:",
    "script-src 'self' 'unsafe-inline' 'unsafe-eval' 'wasm-unsafe-eval' blob:",
    "connect-src 'self' data: blob:",
    "img-src 'self' data: blob:",
    "media-src 'self' data: blob:",
    "worker-src 'self' blob:",
    "object-src 'self' data: blob:",
    "frame-src 'self' data: blob: about:",
    "style-src 'self' 'unsafe-inline'",
    "base-uri 'self'",
    "form-action 'none'"
  ].join("; ");
  document.head.prepend(csp);

  function installLauncherToolbarSuppression() {
    const style = document.createElement("style");
    style.textContent = [
      "#icon-group-0 {",
      "  display: none !important;",
      "  visibility: hidden !important;",
      "  pointer-events: none !important;",
      "}"
    ].join("\n");
    document.head.append(style);
  }

  installLauncherToolbarSuppression();

  function installAdAutoDismissal() {
    const style = document.createElement("style");
    style.textContent = [
      "#m-o, #m-i, #ad-sign, #loading-start-button,",
      "#ib-o, #ib-i, #ibc, #ib-idle, #ib-hover,",
      "[id^='debug-'][id$='-o'], [id^='debug-'][id$='-i'] {",
      "  opacity: 0 !important;",
      "  visibility: hidden !important;",
      "  pointer-events: none !important;",
      "}"
    ].join("\n");
    document.head.append(style);

    const adSelectors = [
      "#m-o",
      "#m-i",
      "#ad-sign",
      "#loading-start-button",
      "#ib-o",
      "#ib-i",
      "#ibc",
      "#ib-idle",
      "#ib-hover",
      "[id^='debug-'][id$='-o']",
      "[id^='debug-'][id$='-i']"
    ].join(",");

    function dismiss() {
      document.querySelectorAll(adSelectors).forEach((element) => {
        element.style.setProperty("opacity", "0", "important");
        element.style.setProperty("visibility", "hidden", "important");
        element.style.setProperty("pointer-events", "none", "important");
      });

      const startButton = document.querySelector("#loading-start-button");
      if (startButton && startButton.dataset.bvnClicked !== "true") {
        startButton.dataset.bvnClicked = "true";
        window.setTimeout(() => startButton.click(), 0);
      }
    }

    new MutationObserver(dismiss).observe(document.documentElement, {
      childList: true,
      subtree: true
    });
    window.setInterval(dismiss, 250);
    document.addEventListener("DOMContentLoaded", dismiss);
    dismiss();
  }

  installAdAutoDismissal();

  function installCanvasWatermarkMask() {
    if (!/\/bvn-2\.6\//.test(location.pathname)) {
      return;
    }

    const mask = document.createElement("div");
    mask.id = "bvn-local-canvas-watermark-mask";
    mask.setAttribute("aria-hidden", "true");
    Object.assign(mask.style, {
      position: "fixed",
      right: "0",
      bottom: "10%",
      width: "30%",
      height: "21%",
      background: "#000",
      zIndex: "2147483647",
      pointerEvents: "none"
    });

    function attach() {
      if (!document.body || document.querySelector("#bvn-local-canvas-watermark-mask")) {
        return;
      }
      document.body.append(mask);
    }

    document.addEventListener("DOMContentLoaded", attach);
    attach();
  }

  installCanvasWatermarkMask();

  function toUrl(value) {
    try {
      if (value instanceof Request) {
        return new URL(value.url, location.href);
      }
      return new URL(String(value), location.href);
    } catch {
      return null;
    }
  }

  function shouldBlock(value) {
    const url = toUrl(value);
    if (!url || (url.protocol !== "http:" && url.protocol !== "https:")) {
      return false;
    }
    return url.origin !== location.origin;
  }

  function localResponseFor(value) {
    const url = toUrl(value);
    if (url && url.hostname === "data.vsgod.win" && url.pathname === "/v1") {
      // Must return a <default> URL whose SWF 404s. Empty <games></games> hangs at 0% splash.
      return new Response(`<games><default>${blankSwfUrl}</default></games>`, {
        status: 200,
        headers: {
          "Content-Type": "application/xml; charset=UTF-8"
        }
      });
    }
    return new Response(null, { status: 204, statusText: "Blocked locally" });
  }

  function record(kind, value) {
    const url = toUrl(value);
    const href = url ? url.href : String(value);
    blocked.push({ kind, url: href, at: new Date().toISOString() });
    console.warn("[BVN local guard] blocked external runtime request:", kind, href);
  }

  function replacementFor(element, attribute, value) {
    const tag = element.tagName ? element.tagName.toLowerCase() : "";
    const name = attribute.toLowerCase();

    if (tag === "script" && name === "src") {
      return emptyScriptUrl;
    }
    if ((tag === "img" || tag === "image") && name === "src") {
      return transparentPixel;
    }
    if ((tag === "iframe" || tag === "frame") && name === "src") {
      return "about:blank";
    }
    if (name === "href" || name === "action" || name === "data") {
      return "about:blank";
    }
    return value;
  }

  function patchUrlProperty(proto, prop, kind, replacement) {
    const descriptor = Object.getOwnPropertyDescriptor(proto, prop);
    if (!descriptor || !descriptor.set || !descriptor.get) {
      return;
    }

    Object.defineProperty(proto, prop, {
      configurable: true,
      enumerable: descriptor.enumerable,
      get() {
        return descriptor.get.call(this);
      },
      set(value) {
        if (shouldBlock(value)) {
          record(kind, value);
          return descriptor.set.call(this, replacement);
        }
        return descriptor.set.call(this, value);
      }
    });
  }

  if (window.fetch) {
    const nativeFetch = window.fetch.bind(window);
    window.fetch = (input, init) => {
      if (shouldBlock(input)) {
        record("fetch", input);
        return Promise.resolve(localResponseFor(input));
      }
      return nativeFetch(input, init);
    };
  }

  if (window.XMLHttpRequest) {
    const nativeOpen = XMLHttpRequest.prototype.open;
    XMLHttpRequest.prototype.open = function open(method, url, ...rest) {
      if (shouldBlock(url)) {
        record("xhr", url);
        return nativeOpen.call(this, method, emptyResponseUrl, ...rest);
      }
      return nativeOpen.call(this, method, url, ...rest);
    };
  }

  if (navigator.sendBeacon) {
    const nativeSendBeacon = navigator.sendBeacon.bind(navigator);
    navigator.sendBeacon = (url, data) => {
      if (shouldBlock(url)) {
        record("beacon", url);
        return false;
      }
      return nativeSendBeacon(url, data);
    };
  }

  patchUrlProperty(HTMLScriptElement.prototype, "src", "script", emptyScriptUrl);
  patchUrlProperty(HTMLImageElement.prototype, "src", "image", transparentPixel);
  patchUrlProperty(HTMLIFrameElement.prototype, "src", "iframe", "about:blank");

  const nativeSetAttribute = Element.prototype.setAttribute;
  Element.prototype.setAttribute = function setAttribute(name, value) {
    if (/^(src|href|data|action)$/i.test(name) && shouldBlock(value)) {
      record(`attr:${this.tagName.toLowerCase()}.${name}`, value);
      return nativeSetAttribute.call(this, name, replacementFor(this, name, value));
    }
    return nativeSetAttribute.call(this, name, value);
  };

  const nativeWindowOpen = window.open;
  window.open = (url, target, features) => {
    if (shouldBlock(url)) {
      record("window.open", url);
      return null;
    }
    return nativeWindowOpen.call(window, url, target, features);
  };

  document.addEventListener(
    "click",
    (event) => {
      const anchor = event.target.closest && event.target.closest("a[href]");
      if (anchor && shouldBlock(anchor.href)) {
        record("click", anchor.href);
        event.preventDefault();
        event.stopPropagation();
      }
    },
    true
  );

  window.__BVN_LOCAL_GUARD__ = {
    blocked,
    shouldBlock(value) {
      return shouldBlock(value);
    }
  };
})();
