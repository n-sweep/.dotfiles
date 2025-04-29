local M = {}
-- local Molten = require('molten')


---- setup ---------------------------------------------------------------------

function M.setup()

    M.define_cells()

    -- send keys
    -- ctrl + enter runs a cell
    vim.keymap.set({'n', 'v'}, '<F33>', function() M.execute() end)

    -- shift + enter runs a cell and sends the cursor to the next cell
    vim.keymap.set({'n', 'v'}, '<F34>', function() M.execute() M.goto_next_cell() end)

    -- shift + tab
    vim.keymap.set('n', '<F31>', function() M.goto_next_cell() end)

    -- alt + tab
    vim.keymap.set('n', '<F32>', function() M.goto_prev_cell() end)

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
        return vim.fn.search(div, 'bnw')
    end
end


-- find the delimiter of the cell below the cell the cursor is currently in
local function get_next_cell(div)
    return vim.fn.search(div, 'nw')
end


-- find the delimiter of the cell above the cell the cursor is currently in
local function get_prev_cell(div)
    -- move to the current cell delimiter
    local current_pos = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_win_set_cursor(0, {get_current_cell(div), 0})
    -- reverse search for the next above
    local prev_cell_line = vim.fn.search(div, 'bnw')
    vim.api.nvim_win_set_cursor(0, current_pos)
    return prev_cell_line
end


local function get_lines_within_cell(div)

    -- find cell divider above cursor
    local cstart = get_current_cell(div)

    -- find cell divider below cursor
    local cend = get_next_cell(div)

    -- if cend is less than cstart (last cell), replace with the end of the buffer
    if cend < cstart then
        cend = vim.fn.line("$")
    end

    return cstart + 1, cend - 1
end


-- determine if cell is already defined under the cursor
local function in_molten_cell()
    local extmarks = vim.api.nvim_buf_get_extmarks(
        0, -1,
        {vim.fn.line('.') - 1, 0},
        {vim.fn.line('.') - 1, -1},
        {details = true}
    )
    for _, mark in ipairs(extmarks) do
        if mark[4] and mark[4].hl_group and mark[4].hl_group == 'MoltenCell' then
            return true
        end
    end
    return false
end


-- move the cursor to the next cell
function M.goto_next_cell()
    local div = get_current_delimiter()
    local cell = get_next_cell(div)

    -- find the first line of the cell; if it is another cell divider,
    -- move the cursor to the divider of this cell
    local firstline = vim.api.nvim_buf_get_lines(0, cell, cell + 1, false)[1]
    print(vim.inspect(firstline))
    if firstline ~= nil and firstline ~= div then
        cell = cell + 1
    end

    vim.api.nvim_win_set_cursor(0, {cell, 0})

end


-- move the cursor to the previous cell
function M.goto_prev_cell()
    local div = get_current_delimiter()
    local cell = get_prev_cell(div)

    -- find the first line of the cell; if it is another cell divider,
    -- move the cursor to this cell's divider instead of the first line of the cell
    local firstline = vim.api.nvim_buf_get_lines(0, cell, cell + 1, false)[1]
    print(vim.inspect(firstline))
    if firstline ~= nil and firstline ~= div then
        cell = cell + 1
    end

    vim.api.nvim_win_set_cursor(0, {cell, 0})

end

-- define all molten cells in the curren buffer
-- (jupytext markdown notebook format)
function M.define_cells()

    local total_cells = 0
    local delimiter = get_current_delimiter()
    local initial_pos = vim.api.nvim_win_get_cursor(0)

    -- position the cursor at the top of the file
    vim.api.nvim_win_set_cursor(0, {1, 1})

    -- start at the first cell
    local cstart = get_next_cell(delimiter)

    while true do

        -- move to the start of the next cell
        vim.api.nvim_win_set_cursor(0, {cstart, 1})

        -- determine the end of the cell
        local cend = get_next_cell(delimiter)

        -- cend will wrap around when the end of the file is reached
        if cstart > cend then
            break
        end

        if (cend - cstart) > 2 then
            vim.fn.MoltenDefineCell(cstart + 1, cend - 2)
            total_cells = total_cells + 1
        end
        cstart = cend

    end

    print('Molten: ' .. total_cells .. ' cells defined')

    -- restore initial cursor position
    vim.api.nvim_win_set_cursor(0, initial_pos)
end


-- execute code / a cell based on the cursor location
function M.execute()

    if in_molten_cell() then
        vim.cmd("MoltenReevaluateCell")
    else
        local cstart, cend = get_lines_within_cell()
        vim.fn.MoltenEvaluateRange(cstart, cend)
    end

end


return M
