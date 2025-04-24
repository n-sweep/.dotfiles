local vim = vim
local M = {}

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

PANE_ID = ''


local function get_current_delimiter()
    local filetype = filetypes[vim.bo.filetype]
    if filetype ~= nil then
        return filetype['delimiter']
    end
    return nil
end


local function get_current_cell(div)
    -- find cell divider above cursor
    if vim.fn.getline("."):find(div) ~= nil then
        return vim.api.nvim_win_get_cursor(0)[1]
    else
        return vim.fn.search(div, 'nbW')
    end
end


local function get_next_cell(div)
    return vim.fn.search(div, 'nW')
end


local function get_prev_cell(div)
    local current_pos = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_win_set_cursor(0, {get_current_cell(div), 0})
    local prev_cell_line = vim.fn.search(div, 'nbW')
    vim.api.nvim_win_set_cursor(0, current_pos)
    return prev_cell_line
end


function M.goto_next_cell()
    local div = get_current_delimiter()
    vim.api.nvim_win_set_cursor(0, {get_next_cell(div), 0})
end


function M.goto_prev_cell()
    local div = get_current_delimiter()
    vim.api.nvim_win_set_cursor(0, {get_prev_cell(div), 0})
end


function M.define_cells()
    local cstart, cend = 1, 1
    local initial_pos = vim.api.nvim_win_get_cursor(0)
    local delimiter = get_current_delimiter()

    vim.api.nvim_win_set_cursor(0, {cstart, 1})

    while cend > 0 do
        cstart = get_next_cell(delimiter)
        vim.api.nvim_win_set_cursor(0, {cstart, 1})
        cend = get_next_cell(delimiter)
        vim.api.nvim_win_set_cursor(0, {cend, 1})
        vim.fn.MoltenDefineCell(cstart, cend - 1)
    end

    -- restore initial cursor position
    vim.api.nvim_win_set_cursor(0, initial_pos)
end


function M.execute()
end


return M
