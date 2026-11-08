#!/bin/bash
# Install missing skills into ~/.agents/skills and link them to every agent.
# Safe to run again. Real folders in agent dirs are moved to a backup, never deleted.

set -e
HUB="$HOME/.agents/skills"
OMARCHY="/usr/share/omarchy/default/agents/skills"
BACKUP="$HOME/skills-backup-$(date +%F)"
AGENTS=(
  "$HOME/.claude/skills"                  # Claude Code
  "$HOME/.codex/skills"                   # Codex
  "$HOME/.gemini/antigravity-cli/skills"  # Antigravity CLI (agy)
)
# OpenCode reads ~/.agents/skills itself, so it needs no links.

cd "$HUB"

# 1. Install skills from other authors (skills.txt)
while read -r repo skill; do
  [ -z "$repo" ] || [ "${repo:0:1}" = "#" ] && continue
  if [ -e "$HUB/$skill" ]; then
    echo "ok      $skill"
  else
    echo "install $skill  ($repo)"
    # "-a codex" puts the skill only in ~/.agents/skills, with no extra links
    npx -y skills add "$repo" -g -a codex -s "$skill" -y </dev/null >/dev/null
  fi
done < skills.txt

# 2. Omarchy skills come from the omarchy package
if [ -d "$OMARCHY" ]; then
  for s in "$OMARCHY"/*/; do
    s=$(basename "$s")
    [ -e "$HUB/$s" ] || { ln -s "$OMARCHY/$s" "$HUB/$s"; echo "linked  $s (omarchy)"; }
  done
fi

# 3. Link every hub skill into each agent
for dir in "${AGENTS[@]}"; do
  mkdir -p "$dir"
  for path in "$HUB"/*/; do
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
