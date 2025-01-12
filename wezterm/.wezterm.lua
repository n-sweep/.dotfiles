local wezterm = require('wezterm')
local act = wezterm.action
local home = os.getenv("HOME")

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

    background = {
        source = { File = home .. '/.wallpaper' },
        attachment = "Fixed",
        vertical_align = "Middle",
        horizontal_align = "Middle",
        height = "Cover",
        width = "Cover"
    },

    keys = {  -- enabling ctrl/shift/alt + Enter/Tab

        -- "AppCursorMode" == send to applications (neovim) only, not terminal input

        {   -- C-Enter sends <F33>
            key = 'Enter', mods = 'CTRL',
            action = act.SendString("\x1b[20;5~"), -- keycodes found with `infocmp` command
            when = "AppCursorMode"
        },
        {   -- S-Enter sends <F34>
            key = 'Enter', mods = 'SHIFT',
            action = act.SendString("\x1b[21;5~"),
            when = "AppCursorMode"
        },
        {   -- M-Enter sends <F35>
            key = 'Enter', mods = 'ALT',
            action = act.SendString("\x1b[23;5~"),
            when = "AppCursorMode"
        },

        {   -- C-Tab sends <F30>
            key = 'Tab', mods = 'CTRL',
            action = act.SendString("\x1b[17;5~"),
            when = "AppCursorMode"
        },
        {   -- S-Tab sends <F31>
            key = 'Tab', mods = 'SHIFT',
            action = act.SendString("\x1b[18;5~"),
            when = "AppCursorMode"
        },
        {   -- M-Tab sends <F32>
            key = 'Tab', mods = 'ALT',
            action = act.SendString("\x1b[19;5~"),
            when = "AppCursorMode"
        },

    }

}

-- if on windows, make wsl the default program
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    config['default_prog'] = {'wsl.exe', '~'}
    config['allow_win32_input_mode'] = false
    config['send_composed_key_when_left_alt_is_pressed'] = false
    config['send_composed_key_when_right_alt_is_pressed'] = false
end

return config
