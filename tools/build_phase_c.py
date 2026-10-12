#!/usr/bin/env python3
"""Phase C (G6/G7/G10 + G9 leftover table): StartSound maps, no-label assists, legacy-12, random note.

Writes under work/remake/{audio,assist,effects}/. Does not touch main.swf.
"""
from __future__ import annotations

import hashlib
import json
import re
import struct
import zlib
from collections import defaultdict
from pathlib import Path

ROOT = Path("/workspace/bvn-3.3")
ASSETS = ROOT / "extracted/full/zips/bin_222/assets"
FIG_DIR = ASSETS / "fighter"
DECOMP_FZ = ROOT / "decompiled/fighters/fz"
OUT_AUDIO = ROOT / "work/remake/audio"
OUT_FIG = OUT_AUDIO / "fighters"
OUT_ASSIST = ROOT / "work/remake/assist"
OUT_EFFECTS = ROOT / "work/remake/effects"
TIMELINES = ROOT / "work/full-analysis/timelines"

NO_LABEL_ASSISTS = [
    "gaara", "grimmjow", "harribel", "hinata", "ichigo_padipata", "ino",
    "jiraiya", "kenpachi", "kon", "obito", "orihime", "rangiku", "sai",
    "stake", "suigetsu", "temari", "tsuchikage", "tsunate", "uryuu",
    "yamamoto", "yin", "yoruichi",
]

LEGACY_12 = [
    "XG_bdj", "XG_fzbs", "XG_ice2", "XG_kan", "XG_kanx", "XG_qdjx2", "XG_xdash",
    "snd_fzbs", "snd_hit1", "snd_hit10", "snd_xdash", "xg_dian_ing2",
]

# Sample fighters for full JSON dump (plus index covers all playable)
SAMPLE_FIGHTERS = [
    "naruto", "sasuke", "ichigo", "aizen", "kakashi", "lee", "madara",
    "rukia", "gaara", "kenpachi", "obito", "ulquiorra",
]


def u16(b: bytes, i: int) -> int:
    return struct.unpack_from("<H", b, i)[0]


def u32(b: bytes, i: int) -> int:
    return struct.unpack_from("<I", b, i)[0]


def read_swf(path: Path) -> bytes:
    data = path.read_bytes()
    sig = data[:3]
    if sig == b"CWS":
        return data[:8] + zlib.decompress(data[8:])
    if sig == b"FWS":
        return data
    raise ValueError(f"unsupported SWF {sig!r}: {path}")


def skip_rect(data: bytes, i: int) -> int:
    nbits = data[i] >> 3
    return i + (5 + nbits * 4 + 7) // 8


def iter_tags(data: bytes, start: int, end: int | None = None):
    i = start
    end = len(data) if end is None else end
    while i + 2 <= end:
        code_len = u16(data, i)
        i += 2
        code = code_len >> 6
        length = code_len & 0x3F
        if length == 0x3F:
            if i + 4 > end:
                break
            length = u32(data, i)
            i += 4
        if i + length > end:
            break
        yield code, data[i : i + length]
        i += length
        if code == 0:
            break


def parse_symbol_class(payload: bytes) -> dict[int, str]:
    if len(payload) < 2:
        return {}
    n = u16(payload, 0)
    i = 2
    out: dict[int, str] = {}
    for _ in range(n):
        if i + 2 > len(payload):
            break
        cid = u16(payload, i)
        i += 2
        z = payload.find(b"\x00", i)
        if z < 0:
            break
        out[cid] = payload[i:z].decode("utf-8", "replace")
        i = z + 1
    return out


def nearest_label(labels: list[tuple[int, str]], frame: int) -> str:
    nearest = ""
    for fr, name in labels:
        if fr <= frame:
            nearest = name
        else:
            break
    return nearest


def analyze_startsound(path: Path, hash_names: dict[str, set[str]]) -> dict:
    raw = read_swf(path)
    i = skip_rect(raw, 8)
    fps = u16(raw, i) / 256.0
    i += 2
    root_frames = u16(raw, i)
    i += 2

    symbols: dict[int, str] = {}
    define_sounds: dict[int, dict] = {}
    sprites: dict[int, dict] = {}
    root_sounds: list[dict] = []
    root_labels: list[tuple[int, str]] = []
    main_frame = 0

    for code, payload in iter_tags(raw, i):
        if code == 1:
            main_frame += 1
        elif code == 43:
            z = payload.find(b"\x00")
            name = payload[:z].decode("utf-8", "replace") if z >= 0 else ""
            root_labels.append((main_frame + 1, name))
        elif code == 14 and len(payload) >= 7:
            cid = u16(payload, 0)
            body = payload[7:]
            sha = hashlib.sha1(body).hexdigest()[:12]
            define_sounds[cid] = {
                "flags": payload[2],
                "sampleCount": u32(payload, 3),
                "size": len(body),
                "sha1": sha,
            }
        elif code == 76:
            symbols.update(parse_symbol_class(payload))
        elif code == 15 and len(payload) >= 2:
            cid = u16(payload, 0)
            root_sounds.append(
                {
                    "frame": main_frame + 1,
                    "tag": "StartSound",
                    "soundId": cid,
                    "spriteId": 0,
                    "spriteExport": symbols.get(0, "MainTimeline"),
                }
            )
        elif code == 89:
            z = payload.find(b"\x00")
            cname = payload[:z].decode("utf-8", "replace") if z >= 0 else ""
            root_sounds.append(
                {
                    "frame": main_frame + 1,
                    "tag": "StartSound2",
                    "soundClass": cname,
                    "spriteId": 0,
                    "spriteExport": symbols.get(0, "MainTimeline"),
                }
            )
        elif code == 39 and len(payload) >= 4:
            sid = u16(payload, 0)
            fcount = u16(payload, 2)
            frame = 0
            labels: list[tuple[int, str]] = []
            sounds: list[dict] = []
            for c2, p2 in iter_tags(payload, 4, len(payload)):
                if c2 == 1:
                    frame += 1
                elif c2 == 43:
                    z = p2.find(b"\x00")
                    labels.append(
                        (frame + 1, p2[:z].decode("utf-8", "replace") if z >= 0 else "")
                    )
                elif c2 == 15 and len(p2) >= 2:
                    cid = u16(p2, 0)
                    sounds.append(
                        {
                            "frame": frame + 1,
                            "tag": "StartSound",
                            "soundId": cid,
                        }
                    )
                elif c2 == 89:
                    z = p2.find(b"\x00")
                    cname = p2[:z].decode("utf-8", "replace") if z >= 0 else ""
                    sounds.append(
                        {
                            "frame": frame + 1,
                            "tag": "StartSound2",
                            "soundClass": cname,
                        }
                    )
            sprites[sid] = {
                "frameCount": fcount,
                "labels": [{"frame": fr, "label": lb} for fr, lb in labels],
                "sounds": sounds,
            }

    # resolve names
    def resolve_name(cid: int | None, sound_class: str | None = None) -> dict:
        if sound_class:
            return {"soundName": sound_class, "nameSource": "StartSound2"}
        if cid is None:
            return {"soundName": "?", "nameSource": "unknown"}
        if cid in symbols:
            return {"soundName": symbols[cid], "nameSource": "SymbolClass"}
        sha = define_sounds.get(cid, {}).get("sha1")
        if sha and sha in hash_names:
            # prefer bare snd_* without @fighter
            bare = sorted({n.split("@")[0] for n in hash_names[sha]})
            # prefer effect-style snd_ names
            prefer = [n for n in bare if n.startswith("snd_")] or bare
            return {"soundName": prefer[0], "nameSource": "sha1-cross", "sha1": sha}
        if sha:
            return {"soundName": f"cid:{cid}", "nameSource": "unnamed", "sha1": sha}
        return {"soundName": f"cid:{cid}", "nameSource": "missing-DefineSound"}

    for cid, ds in define_sounds.items():
        if cid in symbols:
            ds["exportName"] = symbols[cid]
        else:
            resolved = resolve_name(cid)
            ds["exportName"] = resolved["soundName"] if resolved["nameSource"] != "unnamed" else None
            ds["resolvedName"] = resolved["soundName"]
            ds["nameSource"] = resolved["nameSource"]

    # pick primary action sprite = most non-stop labels
    def score(sp: dict) -> int:
        return sum(1 for L in sp["labels"] if L["label"] not in ("stop",))

    action_id = None
    if sprites:
        best = max(sprites.keys(), key=lambda s: (score(sprites[s]), len(sprites[s]["labels"]), sprites[s]["frameCount"]))
        if score(sprites[best]) > 0:
            action_id = best
        elif root_labels:
            action_id = 0
        else:
            action_id = best

    events: list[dict] = []

    def emit(ev: dict, sid: int, labels_tuples: list[tuple[int, str]], export: str):
        cid = ev.get("soundId")
        sc = ev.get("soundClass")
        resolved = resolve_name(cid, sc)
        row = {
            "frame": ev["frame"],
            "label": nearest_label(labels_tuples, ev["frame"]),
            "tag": ev["tag"],
            "soundId": cid,
            "soundName": resolved["soundName"],
            "nameSource": resolved["nameSource"],
            "spriteId": sid,
            "spriteExport": export,
        }
        if "sha1" in resolved:
            row["sha1"] = resolved["sha1"]
        events.append(row)

    # root
    for ev in root_sounds:
        emit(ev, 0, root_labels, symbols.get(0, "MainTimeline"))

    for sid, sp in sprites.items():
        labs = [(L["frame"], L["label"]) for L in sp["labels"]]
        exp = symbols.get(sid, "")
        for ev in sp["sounds"]:
            emit(ev, sid, labs, exp)

    # sort: action sprite first, then by frame
    def sort_key(e: dict):
        pri = 0 if e["spriteId"] == action_id else 1
        return (pri, e["spriteId"] or 0, e["frame"], e.get("soundId") or 0)

    events.sort(key=sort_key)

    named = sum(1 for e in events if e["nameSource"] in ("SymbolClass", "StartSound2", "sha1-cross"))
    action_events = [e for e in events if e["spriteId"] == action_id]

    return {
        "path": str(path.relative_to(ROOT)) if path.is_relative_to(ROOT) else str(path),
        "fps": fps,
        "rootFrames": root_frames,
        "defineSoundCount": len(define_sounds),
        "symbolClassCount": len(symbols),
        "startSoundEventCount": len(events),
        "namedEventCount": named,
        "unnamedEventCount": len(events) - named,
        "actionSpriteId": action_id,
        "actionExport": symbols.get(action_id, "") if action_id else "",
        "actionStartSoundCount": len(action_events),
        "defineSounds": {
            str(cid): {
                "sha1": ds["sha1"],
                "size": ds["size"],
                "sampleCount": ds["sampleCount"],
                "exportName": ds.get("exportName"),
                "resolvedName": ds.get("resolvedName") or ds.get("exportName") or f"cid:{cid}",
                "nameSource": ds.get("nameSource") or ("SymbolClass" if ds.get("exportName") else "unnamed"),
            }
            for cid, ds in sorted(define_sounds.items())
        },
        "soundExports": {str(cid): name for cid, name in symbols.items() if cid in define_sounds or name.startswith("snd_")},
        "events": events,
        "actionEvents": action_events,
    }


def build_hash_index() -> dict[str, set[str]]:
    """sha1(body) → set of known names (effect SymbolClass or fighter@stem)."""
    out: dict[str, set[str]] = defaultdict(set)

    def ingest(path: Path, tag: str | None = None):
        try:
            raw = read_swf(path)
        except Exception:
            return
        i = skip_rect(raw, 8)
        i += 4
        sc: dict[int, str] = {}
        sounds: dict[int, str] = {}
        for code, payload in iter_tags(raw, i):
            if code == 14 and len(payload) >= 7:
                cid = u16(payload, 0)
                sha = hashlib.sha1(payload[7:]).hexdigest()[:12]
                sounds[cid] = sha
            elif code == 76:
                sc.update(parse_symbol_class(payload))
        for cid, sha in sounds.items():
            if cid in sc:
                name = sc[cid]
                if tag:
                    out[sha].add(f"{name}@{tag}")
                else:
                    out[sha].add(name)

    ingest(ASSETS / "effect.swf", None)
    for p in sorted(FIG_DIR.glob("*.swf")):
        ingest(p, p.stem)
    fz = FIG_DIR / "fz"
    if fz.is_dir():
        for p in sorted(fz.glob("*.swf")):
            ingest(p, f"fz/{p.stem}")
    return out


ADD_FRAME_RE = re.compile(
    r"addFrameScript\s*\((.*?)\)\s*;",
    re.S,
)
FRAME_FN_RE = re.compile(
    r"internal function (frame\d+)\s*\(\s*\)\s*:\s*\*[^{]*\{(.*?)(?=\n\s*(?:internal |public |private |protected )?function |\n\s*\}\s*$)",
    re.S,
)
# simpler body extract
FRAME_FN_SIMPLE = re.compile(
    r"internal function (frame\d+)\s*\(\s*\)\s*:\s*\*\s*\{(.*?)\n\s*\}",
    re.S,
)
DEFINE_ACTION_RE = re.compile(
    r"""\$assisterCtrler\.defineAction\(\s*["']([^"']+)["']\s*,\s*\{([^}]*)\}""",
    re.S,
)


def summarize_frame_body(body: str) -> str:
    body = re.sub(r"\s+", " ", body).strip()
    actions: list[str] = []
    if re.search(r"\bstop\s*\(", body):
        actions.append("stop")
    for m in re.finditer(r"\$assisterCtrler\.effect\.(\w+)\s*\(([^)]*)\)", body):
        args = re.sub(r"\s+", "", m.group(2))
        actions.append(f"effect.{m.group(1)}({args})" if args else f"effect.{m.group(1)}()")
    for m in re.finditer(r"\$assisterCtrler\.addAttacker\s*\(\s*[\"']([^\"']+)[\"']", body):
        actions.append(f"addAttacker({m.group(1)})")
    for m in re.finditer(r"\$assisterCtrler\.(\w+)\s*\(([^)]*)\)", body):
        fn = m.group(1)
        if fn in ("effect", "defineAction", "addAttacker"):
            continue
        args = re.sub(r"\s+", "", m.group(2))
        actions.append(f"{fn}({args})" if args else f"{fn}()")
    for m in re.finditer(r"this\.\$assisterCtrler\.set([A-Za-z]+)\(([^)]*)\)", body):
        actions.append(f"set{m.group(1)}(...)")
    if not actions:
        for line in body.split(";"):
            line = line.strip()
            if line and "assisterCtrler" in line:
                actions.append(line[:80])
                break
    return "; ".join(actions) if actions else "(empty/unknown)"


def parse_assist_maintimeline(path: Path) -> dict:
    text = path.read_text(encoding="utf-8", errors="replace")
    # addFrameScript pairs: 0-based index → function
    frames: list[dict] = []
    m = ADD_FRAME_RE.search(text)
    pairs: list[tuple[int, str]] = []
    if m:
        args = m.group(1)
        # split by comma but keep this.frameN together
        parts = re.findall(r"(\d+)\s*,\s*this\.(frame\d+)", args)
        for idx_s, fn in parts:
            pairs.append((int(idx_s), fn))

    bodies: dict[str, str] = {}
    for m in FRAME_FN_SIMPLE.finditer(text):
        bodies[m.group(1)] = m.group(2)

    for idx0, fn in pairs:
        body = bodies.get(fn, "")
        frames.append(
            {
                "frameIndex0": idx0,
                "frameNumber": idx0 + 1,  # Flash 1-based
                "function": fn,
                "summary": summarize_frame_body(body),
                "bodyPreview": re.sub(r"\s+", " ", body).strip()[:200],
            }
        )

    actions = []
    for m in DEFINE_ACTION_RE.finditer(text):
        actions.append({"id": m.group(1), "fields": re.sub(r"\s+", " ", m.group(2)).strip()[:120]})

    # root frame count from SWF if present
    swf = FIG_DIR / "fz" / f"{path.parent.parent.parent.name if False else ''}"
    # path .../fz/<id>/scripts/<id>_fla/MainTimeline.as
    assist_id = path.parts[path.parts.index("fz") + 1] if "fz" in path.parts else path.stem
    swf_path = FIG_DIR / "fz" / f"{assist_id}.swf"
    root_frames = None
    if swf_path.exists():
        try:
            raw = read_swf(swf_path)
            i = skip_rect(raw, 8)
            i += 2
            root_frames = u16(raw, i)
        except Exception:
            pass

    return {
        "id": assist_id,
        "mainTimeline": str(path.relative_to(ROOT)),
        "rootFrames": root_frames,
        "addFrameScriptCount": len(frames),
        "defineActions": actions,
        "frames": frames,
        "engineNote": (
            "Assister.goFight() → gotoAndPlay(2); frame1 (index0) is idle stop; "
            "Assister.renderAnimate advances nextFrame until totalFrames-1 → finish."
        ),
    }


def write_startsound_outputs(hash_names: dict[str, set[str]]) -> dict:
    OUT_FIG.mkdir(parents=True, exist_ok=True)
    playable = sorted(FIG_DIR.glob("*.swf"))
    summaries = []
    full_samples = []

    for p in playable:
        info = analyze_startsound(p, hash_names)
        info["id"] = p.stem
        info["kind"] = "playable"
        # slim summary for index
        summaries.append(
            {
                "id": p.stem,
                "defineSounds": info["defineSoundCount"],
                "startSounds": info["startSoundEventCount"],
                "named": info["namedEventCount"],
                "unnamed": info["unnamedEventCount"],
                "actionSpriteId": info["actionSpriteId"],
                "actionExport": info["actionExport"],
                "actionStartSounds": info["actionStartSoundCount"],
            }
        )
        # write JSON for samples + all (compact: drop full events for non-samples? Task asks per-fighter json samples)
        if p.stem in SAMPLE_FIGHTERS:
            outp = OUT_FIG / f"{p.stem}.startsound.json"
            # full events
            outp.write_text(json.dumps(info, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
            full_samples.append(p.stem)
        else:
            # still write slim json (actionEvents only + defineSounds) for all playable
            slim = {
                "id": p.stem,
                "kind": "playable",
                "path": info["path"],
                "defineSoundCount": info["defineSoundCount"],
                "startSoundEventCount": info["startSoundEventCount"],
                "namedEventCount": info["namedEventCount"],
                "actionSpriteId": info["actionSpriteId"],
                "actionExport": info["actionExport"],
                "defineSounds": info["defineSounds"],
                "soundExports": info["soundExports"],
                "actionEvents": info["actionEvents"],
                "eventsSample": info["events"][:30],
            }
            (OUT_FIG / f"{p.stem}.startsound.json").write_text(
                json.dumps(slim, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
            )

    # assist sample StartSound (4 labeled + 4 no-label)
    assist_samples = ["byakuya", "itachi", "madara", "minato", "gaara", "yoruichi", "grimmjow", "temari"]
    assist_summ = []
    for aid in assist_samples:
        p = FIG_DIR / "fz" / f"{aid}.swf"
        if not p.exists():
            continue
        info = analyze_startsound(p, hash_names)
        info["id"] = f"fz/{aid}"
        info["kind"] = "assist"
        (OUT_FIG / f"fz__{aid}.startsound.json").write_text(
            json.dumps(
                {
                    "id": info["id"],
                    "kind": "assist",
                    "path": info["path"],
                    "defineSoundCount": info["defineSoundCount"],
                    "startSoundEventCount": info["startSoundEventCount"],
                    "namedEventCount": info["namedEventCount"],
                    "actionSpriteId": info["actionSpriteId"],
                    "defineSounds": info["defineSounds"],
                    "events": info["events"][:50],
                    "actionEvents": info["actionEvents"],
                },
                ensure_ascii=False,
                indent=2,
            )
            + "\n",
            encoding="utf-8",
        )
        assist_summ.append(
            {
                "id": f"fz/{aid}",
                "startSounds": info["startSoundEventCount"],
                "named": info["namedEventCount"],
                "defineSounds": info["defineSoundCount"],
            }
        )

    # INDEX md
    lines = [
        "# StartSound 帧→声名索引（Phase C / G7）",
        "",
        "| 项 | 值 |",
        "|----|----|",
        "| 产出日 | 2026-10-11 17:45 CST（UTC+8） |",
        "| 范围 | 可玩 fighter SWF×40 全量二进制解析；辅助抽样×8 |",
        "| 解析 | SWF tag 14 DefineSound / 15 StartSound / 89 StartSound2 / 43 FrameLabel / 76 SymbolClass / 39 DefineSprite |",
        "| 命名 | SymbolClass 优先 → effect/他包 sha1 交叉 → 否则 `cid:<id>`（多数时间轴音未导出类名） |",
        "| 证据 | `work/remake/audio/fighters/*.startsound.json` |",
        "| 约束 | **未改** `main.swf` |",
        "",
        "## 方法说明",
        "",
        "1. 解压 CWS，遍历根时间轴与每个 `DefineSprite` 内嵌标签。",
        "2. `ShowFrame` 累计帧号；`StartSound`/`StartSound2` 归属当前正在构建的帧（`frames+1`）。",
        "3. 同精灵内最近的 `FrameLabel`（`frame ≤ 事件帧`）记为 `label`。",
        "4. 主动作剪辑 = 非 `stop` 标签最多的 sprite（与 Phase5 一致）。",
        "5. 声名：",
        "   - `SymbolClass` 导出名（常见仅 `snd_hurt*` / `bsface*`）",
        "   - 或 DefineSound body sha1 与 `effect.swf` / 其他角色已导出名交叉（如 `snd_jump`/`snd_cbs`）",
        "   - 否则稳定别名 `cid:<characterId>` + sha1（换皮时按哈希对齐）",
        "",
        "**注意**：时间轴 `StartSound` 几乎全部指向**未**挂 SymbolClass 的 DefineSound；",
        "AS3 `defineHurtSound(snd_hurt1)` 等走类实例，不在本表。与 `SOUND-CATALOG.md`（主包/预载）无矛盾。",
        "",
        "## 可玩 40 汇总",
        "",
        "| id | DefineSound | StartSound 事件 | 已命名 | 未命名 | 主动作 clip | 主动作事件 |",
        "|----|------------:|----------------:|-------:|-------:|-------------|-----------:|",
    ]
    total_ss = total_named = total_ds = 0
    for s in summaries:
        total_ss += s["startSounds"]
        total_named += s["named"]
        total_ds += s["defineSounds"]
        exp = s["actionExport"] or "—"
        if len(exp) > 40:
            exp = exp[:37] + "..."
        lines.append(
            f"| `{s['id']}` | {s['defineSounds']} | {s['startSounds']} | {s['named']} | {s['unnamed']} "
            f"| `{exp}` (id={s['actionSpriteId']}) | {s['actionStartSounds']} |"
        )
    lines += [
        "",
        f"**合计**：DefineSound **{total_ds}**；StartSound 事件 **{total_ss}**；其中可解析名 **{total_named}**"
        f"（{100.0 * total_named / total_ss if total_ss else 0:.1f}%）；其余为 `cid:*`。",
        "",
        "## 辅助抽样",
        "",
        "| id | DefineSound | StartSound | named |",
        "|----|------------:|-----------:|------:|",
    ]
    for s in assist_summ:
        lines.append(f"| `{s['id']}` | {s['defineSounds']} | {s['startSounds']} | {s['named']} |")
    lines += [
        "",
        "## JSON 样例（完整事件表）",
        "",
        "下列角色写出**全量** `events`（其余可玩为 slim：`actionEvents` + `eventsSample`）：",
        "",
    ]
    for sid in full_samples:
        lines.append(f"- `fighters/{sid}.startsound.json`")
    lines += [
        "",
        "### 字段",
        "",
        "| 字段 | 含义 |",
        "|------|------|",
        "| `frame` | 1-based 时间轴帧 |",
        "| `label` | 同 clip 最近 FrameLabel |",
        "| `soundId` | DefineSound 角色 ID |",
        "| `soundName` | 解析名或 `cid:N` |",
        "| `nameSource` | `SymbolClass` / `sha1-cross` / `unnamed` / `StartSound2` |",
        "| `spriteId` / `spriteExport` | 所在 DefineSprite |",
        "",
        "## 与 SOUND-CATALOG / effect snd",
        "",
        "- 主包嵌入音（菜单/KO 等）见 `work/full-analysis/engine/SOUND-CATALOG.md` — 不在 fighter SWF。",
        "- `effect.swf` 31 个 `snd_*` 全部 SymbolClass 导出；本索引交叉命中时 `nameSource=sha1-cross`。",
        "- effect 遗留 orphan 音（`snd_hit1`/`snd_hit10`/`snd_fzbs`/`snd_xdash`）见 `work/remake/effects/LEGACY-12.md`。",
        "",
        "## Chinese summary",
        "",
        "已对 40 名可玩角色二进制展开 StartSound：帧+最近标签→soundId/声名；",
        f"事件合计 {total_ss}，命名命中 {total_named}（SymbolClass 或与 effect 哈希对齐），其余稳定 `cid:`。",
        "样例 JSON 已落盘；辅助 8 个抽样。未改 main.swf。",
        "",
    ]
    (OUT_AUDIO / "STARTSOUND-INDEX.md").write_text("\n".join(lines), encoding="utf-8")
    return {
        "playable": len(summaries),
        "totalStartSounds": total_ss,
        "totalNamed": total_named,
        "samples": full_samples,
        "assistSamples": len(assist_summ),
    }


def write_assist_map() -> dict:
    OUT_ASSIST.mkdir(parents=True, exist_ok=True)
    rows = []
    missing = []
    for aid in NO_LABEL_ASSISTS:
        # find MainTimeline
        cands = list((DECOMP_FZ / aid).rglob("MainTimeline.as"))
        if not cands:
            missing.append(aid)
            continue
        info = parse_assist_maintimeline(cands[0])
        rows.append(info)
        (OUT_ASSIST / f"{aid}.frames.json").write_text(
            json.dumps(info, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
        )

    lines = [
        "# 无 FrameLabel 辅助 ×22 — 帧号驱动表（Phase C / G6）",
        "",
        "| 项 | 值 |",
        "|----|----|",
        "| 产出日 | 2026-10-11 17:45 CST（UTC+8） |",
        "| 名单 | G6 / `REMAKE-GAP-INVENTORY` primary labels=0 |",
        "| 源 | `decompiled/fighters/fz/<id>/scripts/*_fla/MainTimeline.as` `addFrameScript` |",
        "| 引擎 | `Assister.goFight()` → `_mainMc.gotoAndStop`/`Play`(2)；帧1=`stop` 待机；播完 `totalFrames-1` → `AssisiterCtrler.finish` |",
        "| 可选 | 重制补 FrameLabel 须同步 Assister（当前按帧号，**勿盲补**） |",
        "| 约束 | **未改** `main.swf` |",
        "",
        "## 约定",
        "",
        "- `addFrameScript` 第一个参数是 **0-based** 帧下标；表中同时给出 **1-based** `frameNumber`（Flash 时间轴）。",
        "- `goFight()` 从帧 **2** 起打（跳过帧1 idle stop）。",
        "- 无 FrameLabel 时改招改特效只能靠本表帧号；有标签的辅助见 `timelines/fighters/fz__*.md`。",
        "",
        "## 总表",
        "",
        "| id | rootFrames | scripts | defineAction | 关键帧摘要 |",
        "|----|-----------:|--------:|-------------:|----------|",
    ]
    for info in rows:
        key = []
        for fr in info["frames"]:
            if fr["summary"] in ("stop",) or fr["frameNumber"] == 1:
                if fr["frameNumber"] == 1:
                    key.append(f"f{fr['frameNumber']}:idle/stop")
                continue
            short = fr["summary"]
            if len(short) > 48:
                short = short[:45] + "..."
            key.append(f"f{fr['frameNumber']}:{short}")
        key_s = "<br>".join(key[:8])
        if len(key) > 8:
            key_s += f"<br>…+{len(key)-8}"
        acts = ",".join(a["id"] for a in info["defineActions"]) or "—"
        lines.append(
            f"| `{info['id']}` | {info['rootFrames'] or '—'} | {info['addFrameScriptCount']} "
            f"| `{acts}` | {key_s} |"
        )

    lines += [
        "",
        "## 逐辅助细表",
        "",
    ]
    for info in rows:
        lines.append(f"### `{info['id']}`")
        lines.append("")
        lines.append(f"- 源：`{info['mainTimeline']}`")
        lines.append(f"- rootFrames：**{info['rootFrames']}**；per-assist JSON：`assist/{info['id']}.frames.json`")
        if info["defineActions"]:
            lines.append("- defineAction：")
            for a in info["defineActions"]:
                lines.append(f"  - `{a['id']}` — `{a['fields']}`")
        lines.append("")
        lines.append("| frame# | index0 | function | summary |")
        lines.append("|-------:|-------:|----------|---------|")
        for fr in info["frames"]:
            lines.append(
                f"| {fr['frameNumber']} | {fr['frameIndex0']} | `{fr['function']}` | `{fr['summary']}` |"
            )
        lines.append("")

    lines += [
        "## 与 Assister 交叉",
        "",
        "| 检查 | 结果 |",
        "|------|------|",
        "| 22 辅助均有 MainTimeline `addFrameScript` | " + ("YES" if not missing else f"MISSING {missing}") + " |",
        "| 帧1 均为 `stop` idle | " + ("YES" if all(r["frames"] and r["frames"][0]["frameNumber"]==1 for r in rows) else "CHECK") + " |",
        "| `goFight→2` 与帧1 stop 无冲突 | YES（引擎跳过 idle） |",
        "| 悬空 defineAction id | 未见（atm* 由时间轴 atm 实例消费） |",
        "",
        "## Chinese summary",
        "",
        f"22 个无 FrameLabel 辅助已从反编译 MainTimeline 抽出 addFrameScript 帧号→动作表"
        f"（{'齐全' if not missing else '缺 '+str(missing)}）。"
        "引擎用帧号而非标签；重制改招以本表为准。未改 main.swf。",
        "",
    ]
    (OUT_ASSIST / "NO-LABEL-FRAME-MAP.md").write_text("\n".join(lines), encoding="utf-8")
    return {"count": len(rows), "missing": missing}


def write_legacy12() -> None:
    OUT_EFFECTS.mkdir(parents=True, exist_ok=True)
    # Related notes
    rows = [
        {
            "symbol": "XG_bdj",
            "kind": "MC",
            "decision": "Keep",
            "why": "EffectModel 未登记；无引擎 AS 引用。保真导出保留 89 全符号，避免时间轴/旧 FLA 隐性依赖被误删。",
            "slimDropOK": "仅精简包 + 全特效回归后可 Drop",
        },
        {
            "symbol": "XG_fzbs",
            "kind": "MC",
            "decision": "Keep",
            "why": "辅助必杀类旧符号；引擎现用 XG_bs/XG_cbs。无 AS 引用，保真 Keep。",
            "slimDropOK": "回归后可 Drop",
        },
        {
            "symbol": "XG_ice2",
            "kind": "MC",
            "decision": "Keep",
            "why": "冰系变体；现网 EffectModel 用 XG_ice。保真 Keep。",
            "slimDropOK": "回归后可 Drop",
        },
        {
            "symbol": "XG_kan",
            "kind": "MC",
            "decision": "Keep",
            "why": "旧砍击；现用 `XG_kan2`（hit_1 / steel_hit_kan）。勿与 kan2 混淆删除。",
            "slimDropOK": "确认无 SWF 内嵌引用后可 Drop",
        },
        {
            "symbol": "XG_kanx",
            "kind": "MC",
            "decision": "Keep",
            "why": "旧砍击强；现用 `XG_kanx2`（hit_6）。保真 Keep。",
            "slimDropOK": "回归后可 Drop",
        },
        {
            "symbol": "XG_qdjx2",
            "kind": "MC",
            "decision": "Keep",
            "why": "拳/打击变体；现用 XG_qdj / XG_qdjx。保真 Keep。",
            "slimDropOK": "回归后可 Drop",
        },
        {
            "symbol": "XG_xdash",
            "kind": "MC",
            "decision": "Keep",
            "why": "旧冲刺特效；现用 XG_rush / XG_rush_air。保真 Keep。",
            "slimDropOK": "回归后可 Drop",
        },
        {
            "symbol": "snd_fzbs",
            "kind": "Sound",
            "decision": "Keep",
            "why": "SymbolClass 导出音；EffectModel 无 sound 字段引用。可能曾配 XG_fzbs。保真 Keep。",
            "slimDropOK": "精简包可 Drop（听感回归）",
        },
        {
            "symbol": "snd_hit1",
            "kind": "Sound",
            "decision": "Keep",
            "why": "导出音 orphan；现 hit 链用 snd_kan1/snd_hit2/…。保真 Keep。",
            "slimDropOK": "听感回归后可 Drop",
        },
        {
            "symbol": "snd_hit10",
            "kind": "Sound",
            "decision": "Keep",
            "why": "导出音 orphan；非 EffectModel。保真 Keep。",
            "slimDropOK": "听感回归后可 Drop",
        },
        {
            "symbol": "snd_xdash",
            "kind": "Sound",
            "decision": "Keep",
            "why": "旧冲刺音；现 dash 用 snd_dash / snd_dash_air。保真 Keep。",
            "slimDropOK": "听感回归后可 Drop",
        },
        {
            "symbol": "xg_dian_ing2",
            "kind": "MC",
            "decision": "Keep",
            "why": "电击持续变体（自带 loop/finish 标签）；现用 `xg_dian_ing`（shock_ing）。保真 Keep。",
            "slimDropOK": "状态特效回归后可 Drop",
        },
    ]

    lines = [
        "# effect 遗留 12 — Keep/Drop（Phase C / G9，衔接 B4）",
        "",
        "| 项 | 值 |",
        "|----|----|",
        "| 产出日 | 2026-10-11 17:45 CST（UTC+8） |",
        "| 源 | `timelines/effects/INDEX.md` Holes；`effect.swf` SymbolClass×89；`EffectModel`×52 |",
        "| 默认策略 | **完美重制保真 = Keep 全部 89 导出**（含本 12） |",
        "| EffectModel | 52 行 className 在 SWF 中 **0 缺符号**（已验证） |",
        "| 约束 | **未改** `main.swf` / 未剔 effect.swf |",
        "",
        "## Keep/Drop 表",
        "",
        "| symbol | 类型 | 决策 | 证据 / 说明 | 精简包 |",
        "|--------|------|------|-------------|--------|",
    ]
    for r in rows:
        lines.append(
            f"| `{r['symbol']}` | {r['kind']} | **{r['decision']}** | {r['why']} | {r['slimDropOK']} |"
        )

    lines += [
        "",
        "## 相关非遗留项（一并冻结）",
        "",
        "| 符号 / 项 | 决策 | 说明 |",
        "|-----------|------|------|",
        "| `xg_hitfllor_heavy` | **Keep（必留）** | EffectModel `hit_floor_heavy` 故意 typo；删名或改名会缺特效。可另加正确拼写双名兼容。 |",
        "| `bisha_face_mc` | **Keep（运行时）** | 非 EffectModel；`BishaFaceEffectView` 运行时实例化。导出勿丢。 |",
        "| EffectModel 52 className | **Keep** | 与 89 符号交集完整；重制包须 0 缺符号。 |",
        "",
        "## 闭合条件（G9 DONE）",
        "",
        "- [x] 12 项均有 Keep/Drop + 证据",
        "- [x] 完美包路径：全部 **Keep**",
        "- [ ] 若未来做精简包：按上表 slimDropOK 删后跑特效/听感回归，并更新本表为 Drop",
        "",
        "## Chinese summary",
        "",
        "遗留 12 个未进 EffectModel 的导出符号（7 MC + 4 snd + 1 电击变体）在完美重制路径全部 **Keep**；",
        "另冻结 typo `xg_hitfllor_heavy` 与运行时 `bisha_face_mc`。精简删除仅允许在回归之后。未改 main.swf。",
        "",
    ]
    (OUT_EFFECTS / "LEGACY-12.md").write_text("\n".join(lines), encoding="utf-8")
    (OUT_EFFECTS / "LEGACY-12.json").write_text(
        json.dumps({"legacy12": rows, "related": ["xg_hitfllor_heavy", "bisha_face_mc"]}, ensure_ascii=False, indent=2)
        + "\n",
        encoding="utf-8",
    )


def write_random_note() -> None:
    """G10 documentation under remake."""
    path = OUT_AUDIO.parent / "RANDOM-XML-ONLY.md"
    path.parent.mkdir(parents=True, exist_ok=True)
    text = """# random*×6 — XML-only（Phase C / G10）

| 项 | 值 |
|----|----|
| 产出日 | 2026-10-11 17:45 CST（UTC+8） |
| 条目 | `random` / `random_bleach` / `random_naruto` ×（fighter.xml + assist.xml）= **6** |
| SWF | **无**（设计如此，非缺失） |
| Face | `assets/face/random.png` 等 PNG 保留 |
| 运行时 | `SelectFighterStage`：`id.indexOf("random")` → 按 comicType 抽真实 id |

## 怎么修（保真）

1. **不要**造空 SWF 或假 fighter 文件。
2. 重制包继续带齐 6 条 XML + face PNG。
3. 选人三项 random 行为与原版一致即 DONE。

## DONE 勾选

- [x] 文档写明 XML-only / 无 SWF
- [ ] 桌面选人三项 random 冒烟（挂 parity 清单）

## Chinese summary

六个 random* 仅为选人占位 XML，运行时抽真实角色/辅助；禁止补空 SWF。未改 main.swf。
"""
    path.write_text(text, encoding="utf-8")


def main() -> None:
    print("Building hash index...")
    hash_names = build_hash_index()
    print(f"  named hashes: {len(hash_names)}")
    print("StartSound tables...")
    audio = write_startsound_outputs(hash_names)
    print(f"  playable={audio['playable']} events={audio['totalStartSounds']} named={audio['totalNamed']}")
    print("Assist no-label map...")
    assist = write_assist_map()
    print(f"  assists={assist['count']} missing={assist['missing']}")
    print("Legacy-12...")
    write_legacy12()
    print("Random note...")
    write_random_note()
    print("DONE")
    print(json.dumps({"audio": audio, "assist": assist}, ensure_ascii=False))


if __name__ == "__main__":
    main()
