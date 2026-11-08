# agent-skills

My global skills for Claude Code, Codex, OpenCode and Antigravity CLI.
All agents use the same skills from one folder: `~/.agents/skills`.

## How it works

The folder `~/.agents/skills` is the hub. Each skill has one real copy in the hub.

| Agent | Where the agent reads skills | Link |
|---|---|---|
| Claude Code | `~/.claude/skills` | One symlink for each skill in the hub |
| Codex | `~/.codex/skills` | One symlink for each skill in the hub |
| Antigravity CLI | `~/.gemini/antigravity-cli/skills` | One symlink for each skill in the hub |
| OpenCode | `~/.agents/skills` | No link. OpenCode reads the hub directly. |

There are three types of skills:

- **My own skills** are in this repo (`break-the-box`, `plugin`).
- **Skills from other authors** are in `skills.txt`. The script installs them from GitHub. The repo does not keep a copy.
- **Omarchy skills** (`omarchy`, `diagnose-crash`) come from the omarchy package. The script links them from `/usr/share/omarchy`.

Claude also has `~/.claude/skills/synced`. Claude Code makes this folder from my claude.ai account. Do not copy it to the hub.

## Set up a new laptop

Before you start, install `git` and `npm`:

```sh
sudo pacman -S git npm
```

1. Clone the repo into the hub folder:

   ```sh
   git clone https://github.com/zaki2993/agent-skills.git ~/.agents/skills
   ```

2. Run the script:

   ```sh
   ~/.agents/skills/setup.sh
   ```

3. Restart all agents.

The script does these steps:

1. It installs each skill from `skills.txt` that is not in the hub.
2. It links the Omarchy skills into the hub.
3. It links every hub skill into Claude, Codex and Antigravity.
4. It moves a real folder with the same name to `~/skills-backup-<date>`. It does not delete folders.
5. It removes links to skills that are not in the hub.

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

3. Add the line `!/my-skill/` to `.gitignore`. If you do not add this line, git ignores the skill.
4. Run `~/.agents/skills/setup.sh`.

**A skill from another author:**

1. Add a line to `skills.txt`: `<github repo> <skill name>`.
2. Run `~/.agents/skills/setup.sh`.

## Update skills

To update the skills from other authors, run this command:

```sh
npx skills update -g
```

To update my own skills, use `git pull` in `~/.agents/skills`.

## Rules

- Do not put real skill folders in the agent folders. Put the skill in the hub, then run the script.
- Do not install skills with `npx skills add` without `-a codex`. Without this flag, the tool can put copies in the agent folders.
- Do not push skills from other authors to this repo. Their license can forbid it.
