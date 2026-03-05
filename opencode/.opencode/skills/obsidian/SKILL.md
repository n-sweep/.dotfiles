---
name: obsidian
description: Create and edit Obsidian notes in the slipbox vault
---

## Vault

- Location: ~/Obsidian/slipbox

## Creating Notes

Always use this nvim command to create new notes:
```
nvim -es -c "lua math.randomseed(vim.loop.hrtime())" -c "Obsidian new_from_template [TITLE] [TEMPLATE]" -c "wq"
```

- Use `Obsidian new` — **DO NOT** use `ObsidianNew`, it is deprecated and will throw an error
- **DO NOT** create notes manually (write tool, echo, etc.) — always use the nvim command, then edit the file if necessary
