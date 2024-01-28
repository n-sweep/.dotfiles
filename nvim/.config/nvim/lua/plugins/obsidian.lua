local fn = vim.fn
local P = { "epwalsh/obsidian.nvim" }

P.version = "*"
P.lazy = true

P.dependencies = {
    'nvim-lua/plenary.nvim',
}

-- populate P.event
P.event = {}
-- always start obsidian when in the obsidian directory
local events = { "BufReadPre", "BufNewFile", "VimEnter" }
local locs = { '/Obsidian', '/Obsidian/*', '/Obsidian/**/*' }
for _, event in pairs(events) do
    for _, loc in pairs(locs) do
        local cmd = event .. " " .. fn.expand("~") .. loc
        table.insert(P.event, cmd)
    end
end

P.opts = {
    workspaces = {
        {
            name = "slipbox",
            path = "~/Obsidian/slipbox",
            overrides = {
                notes_subdir = "notes",
                daily_notes = {
                    folder = "notes/daily"
                }
            }
        },
        {
            name = "cl",
            path = "~/Obsidian/cl",
            overrides = {
                notes_subdir = "notes"
            }
        },
    },
    completion = {
        new_notes_location = "notes_subdir"
    },
}

return P
