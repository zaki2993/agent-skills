#!/bin/bash
# Set up global AGENTS.md and skills in ~/.agents and link them to every agent.
# Safe to run again. Existing files and folders are moved to a backup, never deleted.

set -e
ROOT="$HOME/.agents"
RULES="$ROOT/AGENTS.md"
HUB="$ROOT/skills"
OMARCHY="/usr/share/omarchy/default/agents/skills"
BACKUP="$HOME/skills-backup-$(date +%F)"
AGENTS=(
  "$HOME/.claude/skills"                  # Claude Code
  "$HOME/.codex/skills"                   # Codex
  "$HOME/.gemini/antigravity-cli/skills"  # Antigravity CLI (agy)
)
# OpenCode reads ~/.agents/skills itself, so it needs no skill links.

# 1. Link AGENTS.md to every agent
if [ ! -f "$RULES" ]; then
  echo "Missing $RULES"
  exit 1
fi

link_rules() {
  local target="$1"
  mkdir -p "$(dirname "$target")"
  if [ -L "$target" ] && [ "$(readlink "$target")" = "$RULES" ]; then
    echo "ok      $target"
    return
  fi
  if [ -e "$target" ] || [ -L "$target" ]; then
    mv "$target" "$target.bak"
    echo "backup  $target.bak"
  fi
  ln -s "$RULES" "$target"
  echo "linked  $target"
}

link_rules "$HOME/.claude/CLAUDE.md"   # Claude Code
link_rules "$HOME/.codex/AGENTS.md"    # Codex
link_rules "$HOME/.gemini/AGENTS.md"   # Antigravity CLI (agy)

# OpenCode: ~/.config/opencode/AGENTS.md is often owned by plugins,
# so load our file through the "instructions" setting instead.
OC="$HOME/.config/opencode/opencode.json"
OLD_RULES='~/.config/agents/AGENTS.md'
NEW_RULES='~/.agents/AGENTS.md'
if [ ! -e "$OC" ]; then
  mkdir -p "$(dirname "$OC")"
  printf '{\n  "$schema": "https://opencode.ai/config.json",\n  "instructions": ["%s"]\n}\n' "$NEW_RULES" > "$OC"
  echo "created $OC"
elif grep -qF "$NEW_RULES" "$OC" && ! grep -qF "$OLD_RULES" "$OC"; then
  echo "ok      $OC"
elif command -v jq >/dev/null 2>&1 && jq -e . "$OC" >/dev/null 2>&1; then
  cp "$OC" "$OC.bak"
  jq --arg old "$OLD_RULES" --arg new "$NEW_RULES" \
    '.instructions = (((.instructions // []) | map(select(. != $old and . != $new))) + [$new])' \
    "$OC.bak" > "$OC"
  echo "updated $OC (backup $OC.bak)"
elif command -v python3 >/dev/null 2>&1; then
  cp "$OC" "$OC.bak"
  python3 - "$OC.bak" "$OC" "$OLD_RULES" "$NEW_RULES" <<'PY'
import json, sys
src, dst, old, new = sys.argv[1:5]
with open(src) as f:
    data = json.load(f)
inst = [x for x in data.get("instructions", []) if x not in (old, new)]
inst.append(new)
data["instructions"] = inst
with open(dst, "w") as f:
    json.dump(data, f, indent=2)
    f.write("\n")
PY
  echo "updated $OC (backup $OC.bak)"
else
  echo "todo    add \"$NEW_RULES\" to instructions in $OC"
fi

# 2. Install skills from other authors (skills.txt)
mkdir -p "$HUB"
cd "$HUB"

while read -r repo skill || [ -n "$repo" ]; do
  [ -z "$repo" ] || [ "${repo:0:1}" = "#" ] && continue
  if [ -e "$HUB/$skill" ]; then
    echo "ok      $skill"
  else
    echo "install $skill  ($repo)"
    # "-a codex" puts the skill only in ~/.agents/skills, with no extra links
    npx -y skills add "$repo" -g -a codex -s "$skill" -y </dev/null >/dev/null
  fi
done < "$ROOT/skills.txt"

# 3. Link Omarchy skills into ~/.agents/skills
if [ -d "$OMARCHY" ]; then
  for s in "$OMARCHY"/*/; do
    [ -d "$s" ] || continue
    s=$(basename "$s")
    [ -e "$HUB/$s" ] || { ln -s "$OMARCHY/$s" "$HUB/$s"; echo "linked  $s (omarchy)"; }
  done
fi

# 4. Link every skill from ~/.agents/skills into each agent
for dir in "${AGENTS[@]}"; do
  mkdir -p "$dir"
  for path in "$HUB"/*/; do
    [ -d "$path" ] || continue
    s=$(basename "$path")
    target="$dir/$s"
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$HUB/$s" ]; then
      continue
    fi
    if [ -e "$target" ] || [ -L "$target" ]; then
      mkdir -p "$BACKUP/$(basename "$(dirname "$dir")")"
      mv "$target" "$BACKUP/$(basename "$(dirname "$dir")")/"
      echo "backup  $target"
    fi
    ln -s "$HUB/$s" "$target"
    echo "linked  $target"
  done
  # Remove links to skills that are gone
  find "$dir" -maxdepth 1 -xtype l -lname "$HUB/*" -print -delete
done

echo "Done. Restart your agents."
