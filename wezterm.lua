local wt = require 'wezterm'
local theme =
  'PencilDark'
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
  'Neopolitan', -- lovely blue, shitty contrast
  'Parker Brothers (terminal.sexy)', -- unique but kinda dark
  'PaulMillr', -- bright and clear
  'PencilDark', -- very nice, matches PencilColors
}
local theme_n = 0
function switch_theme(number, window)
  theme_n = theme_n + number
  if theme_n < 1 then theme_n = #themes end
  if theme_n > #themes then theme_n = 1 end
  window:set_config_overrides { color_scheme = themes[theme_n] }
end
wt.on('prev-theme', function(window) switch_theme(-1, window) end)
wt.on('next-theme', function(window) switch_theme( 1, window) end)
wt.on('reset-theme', function(window) window:set_config_overrides {} end)
wt.on('light-theme', function(window)
        window:set_config_overrides {
          harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
          font_size = 16,
          color_scheme = 'PencilLight',
        }
end)
wt.on('query-theme', function(window)
        overrides = window:get_config_overrides()
        wt.log_info(overrides['color_scheme'])
end)
return {
  font_size = 15,
  bold_brightens_ansi_colors = false,
  use_resize_increments = true,
  color_scheme = theme,
  keys = {
    { key = 'c', mods = 'META', action = wt.action.Copy  },
    { key = 'v', mods = 'META', action = wt.action.Paste },
    { key = 'a', mods = 'META', action = wt.action.EmitEvent 'prev-theme'  },
    { key = 's', mods = 'META', action = wt.action.EmitEvent 'next-theme'  },
    { key = 'd', mods = 'META', action = wt.action.EmitEvent 'light-theme' },
    { key = 'q', mods = 'META', action = wt.action.EmitEvent 'query-theme' },
  },
  window_padding = {
    left = 0, right = 0, top = 0, bottom = 0,
  },
  cursor_blink_rate = 0,
}
