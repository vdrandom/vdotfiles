local wt = require('wezterm')

local current = {}

-- colors
local color_scheme = 'Solarized Light (Gogh)'
local tab_fg = '#657b83'
local tab_bg = '#eee8d5'
local tab_bg_active = '#fdf6e3'

-- fonts
local fonts = wt.config_builder()
fonts.font = wt.font{
    family = 'JetBrains Mono',
    harfbuzz_features = {'zero'}
}

-- theme
local theme = wt.config_builder()
theme.color_scheme = color_scheme
theme.colors = {
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
theme.colors.tab_bar.inactive_tab_hover = theme.colors.tab_bar.inactive_tab
theme.window_frame = {
    active_titlebar_bg = tab_bg,
    inactive_titlebar_bg = tab_bg
}

local overrides = {
    fonts = fonts,
    theme = theme
}

local function toggle_overrides(window, conf)
    for k, v in pairs(conf) do
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
