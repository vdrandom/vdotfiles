local wt = require('wezterm')
local act = wt.action
local font = 'Cascadia Code PL'
local font_features = { 'ss01=1', 'ss02=1', 'ss19=1' }
local fontsizes = { Darwin = 14, others = 11 }
local themes = { dark = 'Gruvbox Dark', light = 'PencilLight' }
local theme = themes.dark
local overrides = {
    fonts = { harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' } },
    theme = { color_scheme = themes.light }
}
local current_overrides = {}

local function get_os()
    local current_os = os.getenv('OS')
    if current_os then return current_os end
    return io.popen('uname -s', 'r'):read()
end

local function set_fontsize(sizes)
    local my_os = get_os()
    if sizes[my_os] then return sizes[my_os] end
    return sizes.others
end

local function toggle_overrides(window, overrides)
    for k, v in pairs(overrides) do
        if current_overrides[k] == v then
            current_overrides[k] = nil
        else
            current_overrides[k] = v
        end
    end
    window:set_config_overrides(current_overrides)
end

local function reset_overrides(window)
    current_overrides = {}
    window:set_config_overrides()
end

wt.on('override-theme', function(window) toggle_overrides(window, overrides.theme) end)
wt.on('override-fonts', function(window) toggle_overrides(window, overrides.fonts) end)
wt.on('reset-overrides', function(window) reset_overrides(window) end)

return {
    audible_bell = 'Disabled',
    font_size = set_fontsize(fontsizes),
    font = wt.font(font),
    harfbuzz_features = font_features,
    color_scheme = theme,
    cursor_blink_rate = 0,
    check_for_updates = false,
    bold_brightens_ansi_colors = false,
    window_padding = {
        left = 0, right = 0, top = 0, bottom = 0,
    },
    leader = { key = 'g', mods = 'CTRL', timeout_milliseconds = 1000 },
    keys = {
        { key = 'c', mods = 'META', action = act.Copy  },
        { key = 'v', mods = 'META', action = act.Paste },
        -- themes
        { key = 'f', mods = 'LEADER', action = act.EmitEvent('override-fonts') },
        { key = 't', mods = 'LEADER', action = act.EmitEvent('override-theme') },
        { key = 'r', mods = 'LEADER', action = act.EmitEvent('reset-overrides') },
        -- tabs
        { key = 'c', mods = 'LEADER', action = act.SpawnTab('DefaultDomain') },
        { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative( 1) },
        { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
        -- panes
        { key = 's', mods = 'LEADER', action = act.SplitVertical  { domain = 'CurrentPaneDomain' } },
        { key = 'v', mods = 'LEADER', action = act.SplitHorizontal{ domain = 'CurrentPaneDomain' } },
        { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection('Left')   },
        { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection('Down')   },
        { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection('Up')     },
        { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection('Right')  },
        { key = 'u', mods = 'LEADER', action = act.RotatePanes('Clockwise')        },
        { key = 'i', mods = 'LEADER', action = act.RotatePanes('CounterClockwise') },
        { key = 'Return', mods = 'LEADER', action = act.TogglePaneZoomState },
        { key = 'Space', mods = 'LEADER', action = act.PaneSelect },
    },
}
