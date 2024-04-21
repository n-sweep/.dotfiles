local wezterm = require('wezterm')
local act = wezterm.action

local config = {
    audible_bell = 'Disabled',
    font = wezterm.font 'mononoki Nerd Font Mono',

    color_scheme = 'Kanagawa (Gogh)',

    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = true,
    force_reverse_video_cursor = true,

    window_decorations = 'RESIZE',
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0
    },

    -- enabling ctrl/shift + Enter
    keys = { -- "AppCursorMode" == send to applications (neovim) only, not terminal input
        {   -- C-Enter sends <F33>
            key = 'Enter', mods = 'CTRL',
            action = act.SendString("\x1b[20;5~"),
            when = "AppCursorMode"
        },
        {   -- S-Enter sends <F34>
            key = 'Enter', mods = 'SHIFT',
            action = act.SendString("\x1b[21;5~"),
            when = "AppCursorMode"
        }
    }

}

-- if on windows, make wsl the default program
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    config['default_prog'] = {'wsl.exe', '~'}
end

return config
