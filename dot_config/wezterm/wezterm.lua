local wt = require('wezterm')
local kb = require('keybinds')
local fn = require('functions')

-- colors
local color_scheme = 'GruvboxDark'
local tab_fg = '#ebdbb2'
local tab_bg = '#504945'
local tab_bg_active = '#282828'

-- misc
local cfg = wt.config_builder()
cfg.leader = kb.leader
cfg.keys = kb.keybinds
cfg.audible_bell = 'Disabled'
cfg.check_for_updates = false

-- fonts & text
cfg.cursor_blink_rate = 0
cfg.bold_brightens_ansi_colors = false
cfg.font = wt.font('Maple Mono NL NF')
cfg.font_size = fn.set_by_os{
    Darwin = 14,
    others = 11
}

-- visuals
cfg.window_decorations = fn.set_by_os{
    Darwin = 'INTEGRATED_BUTTONS|RESIZE',
    others = 'TITLE|RESIZE'
}
cfg.native_macos_fullscreen_mode = false
cfg.xcursor_theme = 'Adwaita'
cfg.show_new_tab_button_in_tab_bar = false
cfg.tab_max_width = 24
cfg.window_padding = {
    left = '5pt',
    right = 0,
    top = '2pt',
    bottom = 0
}

-- theming
cfg.color_scheme = color_scheme
cfg.colors = {
    tab_bar = {
        background = tab_bg,
        active_tab = {
            fg_color = tab_fg,
            bg_color = tab_bg_active
        },
        inactive_tab = {
            fg_color = tab_fg,
            bg_color = tab_bg,
        }
    }
}
cfg.colors.tab_bar.inactive_tab_hover = cfg.colors.tab_bar.inactive_tab
cfg.window_frame = {
    active_titlebar_bg = tab_bg,
    inactive_titlebar_bg = tab_bg
}

-- callbacks
wt.on('format-window-title', function() return 'WezTerm' end)
require('overrides')

return cfg
