local vim = vim
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
        nvim_cmp = true,
        new_notes_location = "notes_subdir"
    },
}

function P.init()
    vim.keymap.set('n', '<CR>', ":ObsidianFollowLink <CR>")
    vim.keymap.set('n', '<leader>bb', ":ObsidianBacklinks <CR>")
    vim.keymap.set('n', '<leader>bt', ":ObsidianToday <CR>")
    vim.keymap.set('n', '<leader>bT', ":ObsidianTomorrow <CR>")
    vim.keymap.set('n', '<leader>by', ":ObsidianYesterday <CR>")
    vim.keymap.set('n', '<leader>bs', ":ObsidianSearch <CR>")
    vim.keymap.set('v', 'bs', ":ObsidianSearch <CR>")
    vim.keymap.set('v', 'bl', ":ObsidianLink <CR>")
    vim.keymap.set('v', 'bL', ":ObsidianLinkNew <CR>")
end

return P
