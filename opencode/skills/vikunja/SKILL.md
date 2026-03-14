# Skill: vikunja

## What I do

I make changes to the user's self-hosted Vikunja instance via the REST API or SSH CLI.

## Connection details

**API**
- Base URL: `https://tasks.sweep.sh/api/v1`
- Token: read from `~/.config/vikunja/token`
- Header: `Authorization: Bearer <token>`

**SSH / CLI**
- Host alias: `tn_front`
- Container: `ix-vikunja-vikunja-1`
- Command pattern: `ssh tn_front docker exec ix-vikunja-vikunja-1 ./vikunja <subcommand>`

Use the API for task/project/label operations. Use the CLI for user management, backups, and instance-level repairs.

## Key conventions

- `PUT` = create, `POST` = update — reversed from REST convention
- Labels and assignees on a task body are read-only; use sub-resource endpoints
- Subtasks are task relations, not a hierarchy

## How to operate

1. Read the token: `cat ~/.config/vikunja/token`
2. Make API calls with curl, using the token in the Authorization header
3. For endpoint/model details, read the relevant section of `~/Obsidian/slipbox/notes/1773100362-YZGR.md` — do not load the whole file, read only what you need
4. Prefer targeted reads over loading the full API note into context
