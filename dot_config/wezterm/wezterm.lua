local wt = require('wezterm')
local kb = require('keybinds')
local fn = require('functions')

-- colors
local color_scheme = 'GruvboxDark'
local tab_fg = '#ebdbb2'
local tab_bg = '#504945'
local tab_bg_active = '#282828'

-- os specific stuff
local myos = fn.set_by_os{
    Darwin = {
        font_size = 14,
        window_decorations = "TITLE | RESIZE"
    },
    others = {
        font_size = 10,
        window_decorations = "RESIZE"
    }
}

-- misc
local cfg = wt.config_builder()
cfg.leader = kb.leader
cfg.keys = kb.keybinds
cfg.audible_bell = 'Disabled'
cfg.check_for_updates = false

-- fonts & text
cfg.cursor_blink_rate = 0
cfg.bold_brightens_ansi_colors = false
cfg.font = wt.font('Cascadia Mono PL')
cfg.harfbuzz_features = {"ss01", "ss19", "ss20"}
cfg.font_size = myos.font_size
-- visuals
cfg.native_macos_fullscreen_mode = false
cfg.window_decorations = myos.window_decorations
cfg.xcursor_theme = 'Adwaita'
cfg.use_fancy_tab_bar = false
cfg.hide_tab_bar_if_only_one_tab = false
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
            bg_color = tab_bg
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
