local vim = vim

-- Execute the results of a motion in the previous pane
local function generate_command(keys, flags)
    flags = flags or ''
    return 'silent !tmux send -' .. flags .. 't .+ ' .. keys
end


local function process_text(text)
    -- escape special characters before sending the command to vim
    -- gotta sub the escape char first \\
    for _, k in ipairs({'\\', '%%', '"', '!', '#' }) do
        text = text:gsub(k, '\\' .. k)
    end
    -- surround with quotes before sending the command to vim
    return '"' .. text .. '"'
end


local function get_selected_lines()
    local vstart = vim.fn.getpos("v")
    local vend = vim.fn.getpos(".")
    return vim.fn.getline(vstart[2], vend[2])
end


local function get_lines_within_cell()
    -- find cell divider above cursor
    local cstart = vim.fn.search('# %%', 'nb') + 1
    -- find cell divider below cursor
    local cend = vim.fn.search('# %%', 'n') - 1

    -- if cend wraps around, replace with -1
    if cstart >= cend then
        cend = -1
    end

    -- remove commented lines
    local output = {}
    for _, str in ipairs(vim.fn.getline(cstart, cend)) do
        if not string.match(str, '^#') then
            table.insert(output, str)
        end
    end

    return output
end


local function get_lines(selection)
    -- prioritize selection first
    if selection then
        return get_selected_lines()
    -- if in a notebook, return the whole cell
    elseif vim.fn.search('# %%', 'n') > 0 then
        return get_lines_within_cell()
    -- otherwise, just return the one line
    else
        return {vim.fn.getline('.')}
    end
end


local function send_keys(selection)
    -- get lines to be sent to vim
    local lines = get_lines(selection)

    for _, text in ipairs(lines) do
        -- send command text
        text = process_text(text)
        local command = generate_command(text, 'l')
        vim.cmd(command)

        -- send carriage return
        vim.cmd(generate_command('Enter'))
        if selection then
            -- exit select mode
            vim.api.nvim_input('<Esc>')
        end
    end
end

vim.keymap.set('n', '<leader>t', function() send_keys(false) end)
vim.keymap.set('v', '<leader>t', function() send_keys(true) end)
