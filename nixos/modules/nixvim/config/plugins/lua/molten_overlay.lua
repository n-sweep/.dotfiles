local vim = vim
local M = {}


---- autocmds ------------------------------------------------------------------
local function autocmds()

    vim.api.nvim_create_autocmd("MoltenInitPost", {
      desc = "Molten notebook setup",
      pattern = "*.ipynb",
      callback = function()
        require('molten_overlay').setup()
      end
    })

end


---- keymaps -------------------------------------------------------------------
local function keymaps(mod)
    -- send keys
    -- ctrl + enter runs a cell
    vim.keymap.set({'n', 'v'}, '<F33>', function() mod.execute() end)

    -- shift + enter runs a cell and sends the cursor to the next cell
    vim.keymap.set({'n', 'v'}, '<F34>', function() mod.execute() mod.goto_next_cell() end)

    -- shift + tab
    vim.keymap.set('n', '<F31>', function() mod.goto_next_cell() end)

    -- alt + tab
    vim.keymap.set('n', '<F32>', function() mod.goto_prev_cell() end)

end


---- module --------------------------------------------------------------------

local filetypes = {
    python = {
        delimiter = '# %%',
        comment = '#',
    },
    markdown = {
        delimiter = '```',
        comment = '#',
    }
}

-- return the delimiter associated with the current buffer's filetype
local function get_current_delimiter()
    local filetype = filetypes[vim.bo.filetype]
    if filetype ~= nil then
        return filetype['delimiter']
    end
    return nil
end


-- find the delimiter of the cell the cursor is currently in
local function get_current_cell(div)
    -- find cell divider above cursor
    if vim.fn.getline("."):find(div) ~= nil then
        return vim.api.nvim_win_get_cursor(0)[1]
    else
        return vim.fn.search(div, 'nbW')
    end
end


-- find the delimiter of the cell below the cell the cursor is currently in
local function get_next_cell(div)
    return vim.fn.search(div, 'nW')
end


-- find the delimiter of the cell above the cell the cursor is currently in
local function get_prev_cell(div)
    -- move to the current cell delimiter
    local current_pos = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_win_set_cursor(0, {get_current_cell(div), 0})
    -- reverse search for the next above
    local prev_cell_line = vim.fn.search(div, 'nbW')
    vim.api.nvim_win_set_cursor(0, current_pos)
    return prev_cell_line
end


-- move the cursor to the next cell
function M.goto_next_cell()
    local div = get_current_delimiter()
    vim.api.nvim_win_set_cursor(0, {get_next_cell(div), 0})
end


-- move the cursor to the previous cell
function M.goto_prev_cell()
    local div = get_current_delimiter()
    vim.api.nvim_win_set_cursor(0, {get_prev_cell(div), 0})
end


-- define all molten cells in the curren buffer
-- (jupytext markdown notebook format)
function M.define_cells()
    local cstart, cend = 1, 1
    local initial_pos = vim.api.nvim_win_get_cursor(0)
    local delimiter = get_current_delimiter()

    -- position the cursor at the top of the file
    vim.api.nvim_win_set_cursor(0, {1, 1})

    while true do

        -- determine the start of the cell
        cstart = get_next_cell(delimiter)
        vim.api.nvim_win_set_cursor(0, {cstart, 1})

        -- determine the end of the cell
        cend = get_next_cell(delimiter)

        -- cend will be 0 when the end of the file is reached
        if cend > 0 then
            vim.api.nvim_win_set_cursor(0, {cend, 1})
            vim.fn.MoltenDefineCell(cstart, cend - 1)
        else
            vim.fn.MoltenDefineCell(cstart, vim.fn.line("$"))
            break
        end

    end

    -- restore initial cursor position
    vim.api.nvim_win_set_cursor(0, initial_pos)
end


function M.execute()
end


function M.setup()
    autocmds(M)
    keymaps(M)
end


return M
