local wt = require('wezterm')

local current = {}
local overrides = {
    fonts = {
        font = wt.font('JetBrains Mono'),
        font_size = 11,
        harfbuzz_features = {'calt=0', 'clig=0', 'liga=0'}
    },
    theme = {color_scheme = 'GruvboxDark'}
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
