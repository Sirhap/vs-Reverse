/**
 * LOCAL Hold stub — NOT the online 4399 Hold instance.
 * Mirrors the shell/game passthrough surface from com.sh.Ǽ + Ctrler4399/GameInterfaceManager.
 * Served only from 127.0.0.1:8765 for R8 local fingerprinting.
 */
(function (global) {
  "use strict";

  var callLog = [];

  function log(name, args) {
    callLog.push({ t: Date.now(), method: name, args: Array.prototype.slice.call(args || []) });
  }

  /** Minimal Hold object the page would inject via timeline.setHold(hold). */
  function MinimalHoldMock(opts) {
    opts = opts || {};
    this.isLog = !!opts.isLog;
    this._serverTime = opts.serverTime || "2026-10-12 01:25:00";
    this._uid = opts.uid || "local-stub-uid";
    this._name = opts.name || "LocalStub";
    this._nickName = opts.nickName || "本地Stub";
  }

  MinimalHoldMock.prototype.showGameList = function () { log("showGameList", arguments); };
  MinimalHoldMock.prototype.showSort = function () { log("showSort", arguments); };
  MinimalHoldMock.prototype.showRefer = function (score) { log("showRefer", arguments); };
  MinimalHoldMock.prototype.changeScore = function (n) { log("changeScore", arguments); };
  MinimalHoldMock.prototype.showLogPanel = function () { log("showLogPanel", arguments); };
  MinimalHoldMock.prototype.userLogOut = function () { log("userLogOut", arguments); this.isLog = false; };
  MinimalHoldMock.prototype.getServerTime = function () {
    log("getServerTime", arguments);
    // Stage event shape expected by Ǽ.ˠ: type=serverTimeEvent, data="Y-M-D H:i:s"
    return this._serverTime;
  };

  /**
   * JS-side reflector of com.sh.Ǽ ServiceHold (static contract).
   * isReady === !!_hold — same as Ǽ.isReady.
   */
  function ServiceHoldReflector() {
    this._hold = null;
    this._loginRet = null;
    this._listenersAttached = false;
  }

  ServiceHoldReflector.prototype.bind = function (userData) {
    this._hold = userData || null;
    this._listenersAttached = true;
    return this;
  };

  Object.defineProperty(ServiceHoldReflector.prototype, "isReady", {
    get: function () { return !!this._hold; }
  });
  Object.defineProperty(ServiceHoldReflector.prototype, "hold", {
    get: function () { return this._hold; }
  });
  Object.defineProperty(ServiceHoldReflector.prototype, "isLog", {
    get: function () { return this._hold ? !!this._hold.isLog : false; }
  });

  ServiceHoldReflector.prototype.showGameList = function () { this._hold && this._hold.showGameList(); };
  ServiceHoldReflector.prototype.showSort = function () { this._hold && this._hold.showSort(); };
  ServiceHoldReflector.prototype.showRefer = function (n) { this._hold && this._hold.showRefer(n); };
  ServiceHoldReflector.prototype.changeScore = function (n) { this._hold && this._hold.changeScore(n); };
  ServiceHoldReflector.prototype.showLogPanel = function () { this._hold && this._hold.showLogPanel(); };
  ServiceHoldReflector.prototype.userLogOut = function () { if (this.isLog) this._hold.userLogOut(); };
  ServiceHoldReflector.prototype.renderTime = function () { this._hold && this._hold.getServerTime(); };

  /** Enumerate surface for fingerprint JSON. */
  function reflectSurface(svc) {
    var hold = svc.hold;
    var holdMethods = [];
    var holdProps = [];
    if (hold) {
      for (var k in hold) {
        if (typeof hold[k] === "function") holdMethods.push(k);
        else holdProps.push(k);
      }
      // prototype methods
      var proto = Object.getPrototypeOf(hold);
      if (proto) {
        Object.getOwnPropertyNames(proto).forEach(function (name) {
          if (name === "constructor") return;
          if (typeof hold[name] === "function" && holdMethods.indexOf(name) < 0) holdMethods.push(name);
        });
      }
    }
    return {
      isReady: svc.isReady,
      isLog: svc.isLog,
      hold_present: !!hold,
      hold_typeName: hold ? (hold.constructor && hold.constructor.name) || typeof hold : null,
      hold_methods: holdMethods.sort(),
      hold_own_props: holdProps.sort(),
      service_passthru: [
        "showGameList", "showSort", "showRefer", "changeScore",
        "showLogPanel", "userLogOut", "renderTime", "isReady", "isLog", "hold"
      ],
      call_log_after_probe: callLog.slice()
    };
  }

  function resetCallLog() { callLog.length = 0; }

  global.R8HoldStub = {
    MinimalHoldMock: MinimalHoldMock,
    ServiceHoldReflector: ServiceHoldReflector,
    reflectSurface: reflectSurface,
    resetCallLog: resetCallLog,
    getCallLog: function () { return callLog.slice(); },
    NOTE: "LOCAL stub only — not online 4399 Hold fingerprint"
  };
})(typeof window !== "undefined" ? window : globalThis);
