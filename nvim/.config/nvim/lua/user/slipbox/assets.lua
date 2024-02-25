local vim = vim
local M = {}
local link_pattern = '%[%[(.-)%]%((.-)%)%]'


-- get the current word under the cursor
local function get_word_under_cursor()
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2] + 1

    local start_col = col
    local end_col = col

    -- find the start and end indices of the word
    while start_col > 1 and line:sub(start_col - 1, start_col - 1):match('%S') do
        start_col = start_col - 1
    end

    while end_col < #line and line:sub(end_col + 1, end_col + 1):match('%S') do
        end_col = end_col + 1
    end

    -- extract the word from line
    return { start_col, end_col, line:sub(start_col, end_col) }
end


local function create_link(start_col, end_col, word)
    -- create a markdown link from word and replace
    local new_str = '[[' .. word .. '](' .. word .. ')]'
    local row = vim.api.nvim_win_get_cursor(0)[1] - 1
    vim.api.nvim_buf_set_text(0, row, start_col - 1, row, end_col, {new_str})
end


local function follow_link(name, file)
    -- edit or create the given file
    vim.api.nvim_command('edit ' .. file .. '.md')

    -- if the buffer is empty (new file) insert the name as a title
    if vim.fn.line('$') == 1 and vim.fn.trim(vim.fn.getline(1)) == '' then
        vim.api.nvim_buf_set_text(0, 0, 0, 0, 0, {'# ' .. name})
    end
end


function M.insert_date()
    -- inserts a timestamp at the cursor
    local date = os.date('%Y%m%d%H%M')
    vim.api.nvim_put({date}, "b", true, true)

    local current_pos = vim.api.nvim_win_get_cursor(0)
    current_pos[2] = current_pos[2] - 1
    vim.api.nvim_win_set_cursor(0, current_pos)
end


function M.create_or_follow_link()
    local start_col, end_col, word = unpack(get_word_under_cursor())
    local name, file = word:match(link_pattern)

    if name and file then
        -- if the string under the cursor is already a link, follow that link
        follow_link(name, file)
    else
        -- replace the word with a link
        create_link(start_col, end_col, word)
    end
end


function M.find_link()
    vim.fn.setreg('/', '\\[\\[\\d\\+\\](\\d\\+)\\]')
    vim.cmd('norm n')
end


return M
