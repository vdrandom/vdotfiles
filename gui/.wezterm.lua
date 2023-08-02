local wt = require('wezterm')
local act = wt.action
local font = 'VascadiaModL'
local harfbuzz_features = nil
local fontsizes = { Darwin = 14, others = 11 }
local theme = 'GruvboxDark'
local overrides = {
    fonts = {
        font = wt.font('JetBrains Mono'),
        harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
    },
    theme = { color_scheme = 'PencilLight' }
}
local tab_bar_bg = '#ebdbae'
local tab_bar_fg = '#282828'
local tab_bar_defaults = {
    bg_color = tab_bar_bg,
    fg_color = tab_bar_fg,
    italic = true
}
local tab_bar_active = {
    bg_color = tab_bar_fg,
    fg_color = tab_bar_bg,
    italic = true
}
local custom_colors = {
    tab_bar = {
        background = tab_bar_bg,
        active_tab = tab_bar_active,
        inactive_tab = tab_bar_defaults,
        inactive_tab_hover = tab_bar_defaults,
        new_tab = tab_bar_defaults,
        new_tab_hover = tab_bar_defaults,
    }
}

local leader_key = { key = 'g', mods = 'CTRL', timeout_milliseconds = 1000 }
local keybinds = {
    { key = 'c', mods = 'META', action = act.CopyTo('Clipboard')    },
    { key = 'v', mods = 'META', action = act.PasteFrom('Clipboard') },
    -- themes
    { key = 'f', mods = 'LEADER', action = act.EmitEvent('override-fonts') },
    { key = 't', mods = 'LEADER', action = act.EmitEvent('override-theme') },
    { key = 'r', mods = 'LEADER', action = act.EmitEvent('override-reset') },
    -- tabs
    { key = 'c', mods = 'LEADER', action = act.SpawnTab('DefaultDomain') },
    { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative( 1) },
    { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
    -- panes
    { key = 's', mods = 'LEADER', action = act.SplitVertical   { domain = 'CurrentPaneDomain' } },
    { key = 'v', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection('Left')   },
    { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection('Down')   },
    { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection('Up')     },
    { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection('Right')  },
    { key = 'u', mods = 'LEADER', action = act.RotatePanes('Clockwise')        },
    { key = 'i', mods = 'LEADER', action = act.RotatePanes('CounterClockwise') },
    { key = 'Return', mods = 'LEADER', action = act.TogglePaneZoomState },
    { key = 'Space', mods = 'LEADER', action = act.PaneSelect },
}
for i = 1, 9 do
    table.insert(
        keybinds,
        { key = tostring(i), mods = 'LEADER', action = act.ActivateTab(i - 1) }
    )
end

local function get_os()
    local current_os = os.getenv('OS')
    if current_os then return current_os end
    return io.popen('uname -s', 'r'):read()
end

local function set_by_os(values)
    local my_os = get_os()
    if values[my_os] then return values[my_os] end
    return values.others
end

local current_overrides = {}
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
wt.on('override-reset', reset_overrides)

return {
    xcursor_theme = 'Adwaita',
    audible_bell = 'Disabled',
    font = wt.font(font),
    font_size = set_by_os(fontsizes),
    harfbuzz_features = harfbuzz_features,
    color_scheme = theme,
    cursor_blink_rate = 0,
    check_for_updates = false,
    bold_brightens_ansi_colors = false,
    window_padding = { left = '5pt', right = 0, top = '2pt', bottom = 0 },
    leader = leader_key,
    keys = keybinds,
    colors = custom_colors,
    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = true,
    tab_max_width = 128
}
