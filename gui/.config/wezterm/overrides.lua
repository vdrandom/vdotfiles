local wt = require('wezterm')
local fn = require('functions')

local current = {}

-- fonts
local fonts = wt.config_builder()
fonts.font = wt.font('JetBrains Mono')
fonts.font_size = fn.set_by_os{
    Darwin = 14,
    others = 11
}
fonts.harfbuzz_features = {'calt=0', 'clig=0', 'liga=0'}

-- theme
local tab_fg = '#ebdbb2'
local tab_bg = '#504945'
local tab_bg_active = '#282828'

local theme = wt.config_builder()
theme.color_scheme = 'GruvboxDark'
theme.colors = {
    cursor_bg = '#d65d0e',
    cursor_fg = '#ebdbb2',
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
theme.colors.tab_bar.active_tab_hover = theme.colors.tab_bar.active_tab
theme.colors.tab_bar.inactive_tab_hover = theme.colors.tab_bar.inactive_tab
theme.window_frame = {
    active_titlebar_bg = tab_bg,
    inactive_titlebar_bg = tab_bg
}

local overrides = {
    fonts = fonts,
    theme = theme
}

local function toggle_overrides(window, overrides)
    for k, v in pairs(overrides) do
        if current[k] == v then
            current[k] = nil
        else
            current[k] = v
        end
    end
    window:set_config_overrides(current)
end

local function reset_overrides(window)
    window:set_config_overrides()
    current = {}
end

wt.on('override-theme', function(window) toggle_overrides(window, overrides.theme) end)
wt.on('override-fonts', function(window) toggle_overrides(window, overrides.fonts) end)
wt.on('override-reset', reset_overrides)
