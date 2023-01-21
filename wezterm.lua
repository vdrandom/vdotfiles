local wt = require 'wezterm'
local act = wt.action
local fontsize_darwin = 14
local fontsize_others = 11
local theme_n = 0
local themes = {
  'BirdsOfParadise',
  'Blazer',
  'BlueBerryPie',
  'Dark+', -- another great one | dark / black
  'Doom Peacock', -- nice | dark / black / vivid
  'DWM rob (terminal.sexy)',
  'duskfox',
  'Elio (Gogh)', -- teh best so far | dark / blue
  'Espresso', -- nice, but more on the average side | dark / black
  'Espresso Libre',
  'Fahrenheit', -- all the colors are wrong, but looks cool | dark / red
  'FlatRemix (Gogh)', -- pretty cool | dark / vivid
  'Galaxy', -- pretty nice | dark / blue
  'Galizur', -- great and vivid | dark
  'GJM (terminal.sexy)', -- nice vivid | dark
  'Glacier', -- vivid, very dark
  'gotham (Gogh)', -- surprisingly good, compared to the vim theme
  'Gruvbox Dark',
  'HemisuDark (Gogh)', -- vivid, but dark
  'hund (terminal.sexy)', -- pretty well-balanced dark
  'Japanesque', -- balanced, average, dark
  'Material (terminal.sexy)', -- unusual combination, balanced
  'Medallion', -- quite fun reddish theme, dark
  'MonaLisa', -- impressively good, but very red and dark
  'Parker Brothers (terminal.sexy)', -- unique but kinda dark
  'PaulMillr', -- bright and clear
  'PencilDark', -- very nice, matches PencilColors
  'Rasi (terminal.sexy)', -- legitemately nice, yet dark
  'Red Planet', -- dull, low contrast
  'Rezza (terminal.sexy)', -- same
  'SeaShells', -- wonderful colors, dark and vivid
  'SleepyHollow', -- unusual colors
  'Srcery (Gogh)', -- nice, but a bit too low on contrast
}
local default_theme = themes[18]
local webinar_overrides = {
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  color_scheme = 'PencilLight',
}

function switch_theme(number, window)
  theme_n = theme_n + number
  if theme_n < 1 then theme_n = #themes end
  if theme_n > #themes then theme_n = 1 end
  window:set_config_overrides { color_scheme = themes[theme_n] }
end

function set_fontsize()
  local execfile = os.getenv('WEZTERM_EXECUTABLE')
  if string.match(execfile, 'MacOS') then return fontsize_darwin end
  return fontsize_others
end

wt.on('update-right-status', function(window, pane)
        local theme_info = string.format(
          '%s %s ', wt.nerdfonts.fa_terminal,
          window:effective_config().color_scheme
        )
        window:set_right_status(wt.format {{ Text = theme_info }})
end)
wt.on('prev-theme', function(window) switch_theme(-1, window) end)
wt.on('next-theme', function(window) switch_theme( 1, window) end)
wt.on('reset-overrides', function(window) window:set_config_overrides() end)
wt.on('webinar', function(window) window:set_config_overrides(webinar_overrides) end)

return {
  audible_bell = 'Disabled',
  font_size = set_fontsize(),
  font = wt.font 'Cascadia Code PL',
  harfbuzz_features = { 'ss01=1', 'ss19=1' },
  color_scheme = default_theme,
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
    { key = 'a', mods = 'META', action = act.EmitEvent 'prev-theme' },
    { key = 's', mods = 'META', action = act.EmitEvent 'next-theme' },
    { key = 'd', mods = 'META', action = act.EmitEvent 'reset-overrides' },
    { key = 'w', mods = 'META', action = act.EmitEvent 'webinar' },
    -- tabs
    { key = 'c', mods = 'LEADER', action = act.SpawnTab 'DefaultDomain' },
    { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative( 1) },
    { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
    -- panes
    { key = 's', mods = 'LEADER', action = act.SplitVertical   { domain = 'CurrentPaneDomain' } },
    { key = 'v', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left'  },
    { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down'  },
    { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up'    },
    { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },
    { key = 'u', mods = 'LEADER', action = act.RotatePanes 'Clockwise'        },
    { key = 'i', mods = 'LEADER', action = act.RotatePanes 'CounterClockwise' },
    { key = 'Return', mods = 'LEADER', action = act.TogglePaneZoomState },
    { key = 'Space', mods = 'LEADER', action = act.PaneSelect },
  },
}
