local wt = require 'wezterm'
local current_theme = 1
local theme =
  'Parker Brothers (terminal.sexy)'
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
}
wt.on('next-theme', function(window)
        if current_theme < #themes then
          current_theme = current_theme + 1
        else
          current_theme = 1
        end
        color_scheme = themes[current_theme]
        wt.log_info(color_scheme)
        window:set_config_overrides {color_scheme=color_scheme}
end)
wt.on('reset-theme', function(window)
        wt.log_info(theme)
        window:set_config_overrides {}
end)
return {
  font_size = 14,
  bold_brightens_ansi_colors = false,
  use_resize_increments = true,
  color_scheme = theme,
  keys = {
    { key = 'c', mods = 'META', action = wt.action.Copy },
    { key = 'v', mods = 'META', action = wt.action.Paste },
    { key = 'z', mods = 'CTRL', action = wt.action.EmitEvent 'next-theme'},
    { key = 'x', mods = 'CTRL', action = wt.action.EmitEvent 'reset-theme' },
  },
  window_padding = {
    left = 0, right = 0, top = 0, bottom = 0,
  },
  cursor_blink_rate = 0,
}
