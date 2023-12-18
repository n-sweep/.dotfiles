local vim = vim
local filetypes = {
    python = '# %%',
    markdown = '```',
    quarto = '```'
}

PANE = ''


-- attach to a specific pane
local function attach_to_pane()
    while PANE == '' do
        vim.cmd('silent !tmux display-panes -Nbd 0')
        PANE = vim.fn.input('Attach to pane: ')
    end
    print('Attached to pane ' .. PANE)
end


-- Execute the results of a motion in the previous pane
local function generate_command(keys, flags)
    flags = flags or ''
    return 'silent !tmux send -' .. flags .. 't '.. PANE .. ' ' .. keys
end


local function process_text(text)
    -- escape special characters before sending the command to vim
    -- gotta sub the escape char first \\
    for _, k in ipairs({ '\\', '%%', '"', '!', '#', '%$' }) do
        text = text:gsub(k, '\\' .. k)
    end
    -- surround with quotes before sending the command to vim
    return '"' .. text .. '"'
end


local function process_lines(lines, filetype)
    local output = {}
    for _, str in ipairs(lines) do

        -- flag to remove commented lines
        -- [TODO] change comments per filetype (?)
         local comment = string.match(str, '^#')
        -- flag to remove empty lines
         local empty = string.match(str, "^%s*$")

        if not comment and not empty then
            local processed = process_text(str)
            table.insert(output, processed)
        end

    end

    local indented = string.match(output[#output], "^\"[%s\t]+") ~= nil
    if filetype == 'python' and indented then
        -- adding two empty lines to close an indented block
        table.insert(output, "")
    end

    return output
end


local function get_lines_within_cell(div)
    -- find cell divider above cursor
    local cstart = vim.fn.search(div, 'nb') + 1
    -- find cell divider below cursor
    local cend = vim.fn.search(div, 'n') - 1

    -- if cend wraps around, replace with -1
    if cstart >= cend then
        cend = -1
    end

    return vim.fn.getline(cstart, cend)
end


local function get_selected_lines()
    local vstart = vim.fn.getpos("v")
    local vend = vim.fn.getpos(".")

    -- if the selection was made backward, flip start and end
    if vstart[2] > vend[2] then
        vend = vim.fn.getpos("v")
        vstart = vim.fn.getpos(".")
    end

    return vim.fn.getline(vstart[2], vend[2])
end


local function get_lines(selection, delimiter)
    -- [TODO] unable to run cells at the end of file (?)
    -- [TODO] unable to run code blocks with one line (?)

    -- prioritize selection first
    if selection then
        return get_selected_lines()
    -- if in a supported file, return the whole cell
    elseif delimiter then
        return get_lines_within_cell(delimiter)
    -- otherwise, just return the one line
    else
        return {vim.fn.getline('.')}
    end
end


local function send_keys(selection)
    local filetype = vim.bo.filetype
    local delimiter = filetypes[filetype]

    if PANE == '' then
        attach_to_pane()
    end

    -- get lines to be sent to vim
    local lines = get_lines(selection, delimiter)
    local processed_lines = process_lines(lines, filetype)

    for _, text in ipairs(processed_lines) do

        -- convert text into a tmux send-keys command
        local command = generate_command(text, 'l')

        -- send command text
        vim.cmd(command)

        -- send carriage return
        vim.cmd(generate_command('Enter'))

    end

    if selection then
        -- exit select mode
        vim.api.nvim_input('<Esc>')
    end

end

vim.keymap.set('n', '<CR>', function() send_keys(false) end)
vim.keymap.set('v', '<CR>', function() send_keys(true) end)
vim.keymap.set('n', '<leader>t', function() print("that doesn't work any more") end)
vim.keymap.set('v', '<leader>t', function() print("that doesn't work any more") end)
