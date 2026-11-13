# agent-skills

My global `AGENTS.md` rules and skills for Claude Code, Codex, OpenCode and Antigravity CLI.
Everything lives in one folder: `~/.agents`.

## How it works

The folder `~/.agents` holds `AGENTS.md` and the `skills/` hub. Each skill has one real copy in `~/.agents/skills`.

| Agent | Global rules (`AGENTS.md`) | Skills |
|---|---|---|
| Claude Code | `~/.claude/CLAUDE.md` -> `~/.agents/AGENTS.md` | `~/.claude/skills/*` -> `~/.agents/skills/*` |
| Codex | `~/.codex/AGENTS.md` -> `~/.agents/AGENTS.md` | `~/.codex/skills/*` -> `~/.agents/skills/*` |
| OpenCode | `instructions` in `~/.config/opencode/opencode.json` | Reads `~/.agents/skills` directly |
| Antigravity CLI | `~/.gemini/AGENTS.md` -> `~/.agents/AGENTS.md` | `~/.gemini/antigravity-cli/skills/*` -> `~/.agents/skills/*` |

There are three types of skills:

- **My own skills** are in this repo (`skills/plugin`).
- **Skills from other authors** are in `skills.txt`. The script installs them from GitHub. The repo does not keep a copy.
- **Omarchy skills** (`omarchy`, `diagnose-crash`) come from the omarchy package. The script links them from `/usr/share/omarchy`.

Claude also has `~/.claude/skills/synced`. Claude Code makes this folder from my claude.ai account. Do not copy it to the hub.

## Set up a new laptop

Before you start, install `git` and `npm`:

```sh
sudo pacman -S git npm
```

1. Clone the repo into `~/.agents`:

   ```sh
   git clone https://github.com/zaki2993/agent-skills.git ~/.agents
   ```

2. Run the script:

   ```sh
   ~/.agents/setup.sh
   ```

3. Restart all agents.

The script does these steps:

1. It links `~/.agents/AGENTS.md` to Claude, Codex, Antigravity CLI and OpenCode (backing up old files as `*.bak`).
2. It installs each skill from `skills.txt` that is not in `~/.agents/skills`.
3. It links the Omarchy skills into `~/.agents/skills`.
4. It links every skill from `~/.agents/skills` into Claude, Codex and Antigravity CLI.
5. It moves any conflicting real skill folder to `~/skills-backup-<date>`. It does not delete folders.
6. It removes links to skills that are gone.

You can run the script again. It changes only what is missing or wrong.

## Add a skill

Use the steps for the skill type.

**My own skill:**

1. Make a folder in the hub, for example `~/.agents/skills/my-skill/`.
2. Put a `SKILL.md` file in the folder. The file must start with this header:

   ```markdown
   ---
   name: my-skill
   description: One line that tells the agent when to use the skill.
   ---
   ```

3. Add the line `!/skills/my-skill/` to `~/.agents/.gitignore`. If you do not add this line, git ignores the skill.
4. Run `~/.agents/setup.sh`.

**A skill from another author:**

1. Add a line to `skills.txt`: `<github repo> <skill name>`.
2. Run `~/.agents/setup.sh`.

## Update skills

To update the skills from other authors, run this command:

```sh
npx skills update -g
```

To update `AGENTS.md` and my own skills, use `git pull` in `~/.agents`.

## Rules

- Edit only `~/.agents/AGENTS.md` for global rules.
- Do not put real skill folders in the agent folders. Put the skill in `~/.agents/skills`, then run `~/.agents/setup.sh`.
- Do not install skills with `npx skills add` without `-a codex`. Without this flag, the tool can put copies in the agent folders.
- Do not push skills from other authors to this repo. Their license can forbid it.
