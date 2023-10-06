require('overrides')
local wt = require('wezterm')
local fn = require('functions')
local keys = require('keybinds')
local cfg = wt.config_builder()

cfg.leader = keys.leader
cfg.keys = keys.keybinds
cfg.xcursor_theme = 'Adwaita'
cfg.audible_bell = 'Disabled'
cfg.font = wt.font('Fantasque Sans Mono')
cfg.harfbuzz_features = nil
cfg.color_scheme = 'Solarized Light (Gogh)'
cfg.cursor_blink_rate = 0
cfg.check_for_updates = false
cfg.bold_brightens_ansi_colors = false
cfg.font_size = fn.set_by_os{
    Darwin = 15,
    others = 12
}
local tab_bar_fg = '#657b83'
local tab_bar_bg = '#eee8d5'
local tab_bar_bg_active = '#fdf6e3'
local tab_bar_defaults = {
    bg_color = tab_bar_bg,
    fg_color = tab_bar_fg,
    italic = true
}
local tab_bar_active = {
    bg_color = tab_bar_bg_active,
    fg_color = tab_bar_fg,
    italic = true
}
cfg.use_fancy_tab_bar = true
cfg.hide_tab_bar_if_only_one_tab = false
cfg.show_new_tab_button_in_tab_bar = false
cfg.tab_max_width = 128
cfg.window_padding = { left = '5pt', right = 0, top = '2pt', bottom = 0 }
cfg.window_decorations = 'INTEGRATED_BUTTONS | RESIZE | MACOS_FORCE_ENABLE_SHADOW'
cfg.window_frame = {
    active_titlebar_bg = tab_bar_bg,
    inactive_titlebar_bg = tab_bar_bg
}
cfg.colors = {
    cursor_bg = '#cb4b16',
    cursor_fg = '#fdf6e3',
    tab_bar = {
        background = tab_bar_bg,
        active_tab = tab_bar_active,
        inactive_tab = tab_bar_defaults,
        inactive_tab_hover = tab_bar_defaults,
    }
}

return cfg
