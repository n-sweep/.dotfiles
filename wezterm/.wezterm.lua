local wezterm = require('wezterm')

local config = {
    audible_bell = 'Disabled',
    font = wezterm.font 'mononoki Nerd Font Mono',

    -- color_scheme = 'GruvboxDark',
    -- color_scheme = 'Everforest Dark (Gogh)',
    color_scheme = 'Kanagawa (Gogh)',
    -- color_scheme = 'Bamboo',
    -- color_scheme = 'nord',

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

}

-- if on windows, make wsl the default program
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    config['default_prog'] = {'wsl.exe', '~'}
end

return config
