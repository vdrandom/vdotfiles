local wt = require('wezterm')
local cfg = wt.config_builder()
local act = wt.action
local current_overrides = {}

cfg.xcursor_theme = 'Adwaita'
cfg.audible_bell = 'Disabled'
cfg.font = wt.font('Fantasque Sans Mono')
cfg.harfbuzz_features = nil
cfg.color_scheme = 'Solarized Light (Gogh)'
cfg.cursor_blink_rate = 0
cfg.check_for_updates = false
cfg.bold_brightens_ansi_colors = false

local fontsizes = { Darwin = 15, others = 12 }
local overrides = {
    fonts = {
        font = wt.font('JetBrains Mono'),
        font_size = 11,
        harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
    },
    theme = { color_scheme = 'GruvboxDark' }
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

cfg.leader = leader_key
cfg.keys = keybinds

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

cfg.font_size = set_by_os(fontsizes)

return cfg
