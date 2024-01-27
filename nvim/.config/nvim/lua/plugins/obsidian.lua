local fn = vim.fn
local P = { "epwalsh/obsidian.nvim" }

P.version = "*"
P.lazy = true

P.dependencies = {
    'nvim-lua/plenary.nvim',
}

P.event = {}

-- always start obsidian when in the obsidian directory
local events = { "BufReadPre", "BufNewFile", "VimEnter" }
local locs = { '/Obsidian/*', '/Obsidian/**/*' }
for _, event in pairs(events) do
    for _, loc in pairs(locs) do
        local cmd = event .. " " .. fn.expand("~") .. loc
        table.insert(P.event, cmd)
    end
end

P.opts = {
    workspaces = {}
}

-- insert each directory in ~/Obsidian as a workspace
local dir = fn.expand( '~/Obsidian')
local dirs = fn.globpath(dir, "*", 0, 1)

-- for each directory, add it to opts.workspaces
for _, filepath in pairs(dirs) do
    if fn.isdirectory(filepath) == 1 then
        table.insert(P.opts.workspaces, {
            name = fn.fnamemodify(filepath, ":t"),
            path = filepath
        })
    end
end

return P
