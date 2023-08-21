local vim = vim


-- Execute the results of a motion in the previous pane
local function create_command(keys, flags)
    flags = flags or ''
    return 'silent !tmux send -' .. flags .. 't .+ ' .. keys
end


local function process_text(text)
    -- escape special characters before sending the command to vim
    for _, k in ipairs({ '%%', '"', '!' }) do
        text = text:gsub(k, '\\' .. k)
    end
    -- surround with quotes before sending the command to vim
    return '"' .. text .. '"'
end


local function send_keys(selection)
    local lines
    if selection then
        local vstart = vim.fn.getpos("v")
        local vend = vim.fn.getpos(".")
        lines = vim.fn.getline(vstart[2], vend[2])
    else
        lines = {vim.fn.getline('.')}
    end

    -- process command and send to vim
    for _, text in ipairs(lines) do
        text = process_text(text)
        local command = create_command(text, 'l')
        print(command)
        vim.cmd(command)

        -- send carriage return
        vim.cmd(create_command('Enter'))
        if selection then
            vim.api.nvim_input('<Esc>')
        end
    end
end

vim.keymap.set('n', '<leader>t', function() send_keys(false) end)
vim.keymap.set('v', '<leader>t', function() send_keys(true) end)






















