#!/usr/bin/env python3
"""Extract EffectModel effectKey → className → snd_* table (Phase E / G12)."""
from __future__ import annotations
import json, re, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_SRC = ROOT / "decompiled/main/scripts/net/play5d/game/bvn/data/EffectModel.as"
OUT_JSON = ROOT / "work/remake/engine/EFFECT-SND-TABLE.json"


def parse(text: str) -> list[dict]:
    text = text.replace("\r\n", "\n")
    rows: list[dict] = []
    for m in re.finditer(
        r'_effect\["([^"]+)"\]\s*=\s*new EffectVO\("([^"]+)"(?:,\s*(\{.*?\}))?\s*\)\s*;',
        text,
        re.S,
    ):
        key, cn, obj = m.group(1), m.group(2), m.group(3) or ""
        sm = re.search(r'"sound"\s*:\s*"([^"]+)"', obj)
        rows.append({"kind": "named", "effectKey": key, "className": cn, "sound": sm.group(1) if sm else None})
    for m in re.finditer(
        r'addHitEffect\((\d+)\s*,\s*"([^"]+)"\s*,\s*(\{.*?\})\s*\)\s*;', text, re.S
    ):
        hid, cn, obj = m.group(1), m.group(2), m.group(3)
        sm = re.search(r'"sound"\s*:\s*"([^"]+)"', obj)
        rows.append({"kind": "hit", "effectKey": f"hit_{hid}", "className": cn, "sound": sm.group(1) if sm else None, "hitId": int(hid)})
    for m in re.finditer(
        r'addDefenseEffect\((\d+)\s*,\s*"([^"]+)"\s*,\s*(\{.*?\})\s*\)\s*;', text, re.S
    ):
        did, cn, obj = m.group(1), m.group(2), m.group(3)
        sm = re.search(r'"sound"\s*:\s*"([^"]+)"', obj)
        rows.append({"kind": "defense", "effectKey": f"defense_{did}", "className": cn, "sound": sm.group(1) if sm else None, "defenseId": int(did)})
    return rows


def main() -> int:
    src = Path(sys.argv[1]) if len(sys.argv) > 1 else DEFAULT_SRC
    rows = parse(src.read_text(encoding="utf-8"))
    with_snd = [r for r in rows if r.get("sound")]
    unique = sorted({r["sound"] for r in with_snd})
    payload = {
        "source": str(src.relative_to(ROOT)) if src.is_relative_to(ROOT) else str(src),
        "count": len(rows),
        "with_sound": len(with_snd),
        "unique_sounds": unique,
        "silent": [r["effectKey"] for r in rows if not r.get("sound")],
        "rows": rows,
        "play_path": "SoundCtrl.playEffectSound → AssetManager.getEffect(snd) → Sound.play (effect.swf SymbolClass)",
        "note": "Legacy export-only snd_* (snd_fzbs/snd_hit1/snd_hit10/snd_xdash) are NOT in EffectModel; see LEGACY-12.md Keep.",
    }
    OUT_JSON.parent.mkdir(parents=True, exist_ok=True)
    OUT_JSON.write_text(json.dumps(payload, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(f"wrote {OUT_JSON} rows={len(rows)} with_sound={len(with_snd)} unique_snd={len(unique)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
