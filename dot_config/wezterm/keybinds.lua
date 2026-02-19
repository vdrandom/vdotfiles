local act = require('wezterm').action

local leader_key = { key = 'g', mods = 'CTRL', timeout_milliseconds = 1000 }
local keybinds = {
    { key = 'c', mods = 'META', action = act.CopyTo('Clipboard')    },
    { key = 'v', mods = 'META', action = act.PasteFrom('Clipboard') },
    -- overrides
    { key = 'y', mods = 'LEADER', action = act.EmitEvent('override-fonts') },
    { key = 't', mods = 'LEADER', action = act.EmitEvent('override-theme') },
    { key = 'r', mods = 'LEADER', action = act.EmitEvent('override-reset') },
    -- misc
    { key = 'f', mods = 'LEADER', action = act.ToggleFullScreen },
    -- tabs
    { key = 'c', mods = 'LEADER', action = act.SpawnTab('DefaultDomain') },
    { key = 't', mods = 'META', action = act.SpawnTab('DefaultDomain') },
    { key = 'w', mods = 'META', action = act.CloseCurrentTab { confirm = true } },
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
    table.insert(
        keybinds,
        { key = tostring(i), mods = 'META', action = act.ActivateTab(i - 1) }
    )
end
local mousebinds = {
    {
        event = { Down = { streak = 1, button = { WheelUp = 1 } } },
        mods = 'NONE',
        action = act.ScrollByLine(-3),
        alt_screen = false,
    },
    {
        event = { Down = { streak = 1, button = { WheelDown = 1 } } },
        mods = 'NONE',
        action = act.ScrollByLine(3),
        alt_screen = false,
    },
}

return {
    leader = leader_key,
    keybinds = keybinds,
    mousebinds = mousebinds
}
