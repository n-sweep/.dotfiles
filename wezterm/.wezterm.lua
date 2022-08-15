local wezterm = require 'wezterm'

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    return { default_prog = {'wsl.exe', '~'} }
end

return {
    font = wezterm.font 'mononoki Nerd Font Mono',
    color_scheme = 'Gruvbox Dark',
    initial_rows = 59,
    initial_cols = 90,
    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = true,
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0
    },
}

