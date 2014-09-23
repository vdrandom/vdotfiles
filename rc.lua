-- Standard awesome library
local gears = require('gears')
local awful = require('awful')
awful.rules = require('awful.rules')
require('awful.autofocus')
-- Widget and layout library
local wibox = require('wibox')
-- Theme handling library
local beautiful = require('beautiful')
-- Notification library
local naughty = require('naughty')
local menubar = require('menubar')

-- enable testing if file exists
function ifexists(name)
	local f=io.open(name,'r')
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = 'Oops, there were errors during startup!',
		text = awesome.startup_errors
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal(
		'debug::error',
		function (err)
			-- Make sure we don't go into an endless error loop
			if in_error then
				return
			end
			in_error = true

			naughty.notify({
				preset = naughty.config.presets.critical,
				title = 'Oops, an error happened!',
				text = err
			})
			in_error = false
		end
	)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init('/home/von/vdotfiles/theme.lua')
theme.border_width = 1
theme.font = 'Terminus 9'

-- set wallpaper
local wallpaper = '/home/von/Pictures/wallpaper.png'
if ifexists(wallpaper) then
	theme.wallpaper = wallpaper
end

-- This is used later as the default terminal and editor to run.
terminal = 'roxterm'
editor = os.getenv('EDITOR') or 'vim'
editor_cmd = terminal .. ' -e ' .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = 'Mod4'

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts = {
	awful.layout.suit.floating,
	awful.layout.suit.tile,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.max
	-- Also possible:
	-- awful.layout.suit.tile.left,
	-- awful.layout.suit.tile.top,
	-- awful.layout.suit.fair,
	-- awful.layout.suit.fair.horizontal,
	-- awful.layout.suit.spiral,
	-- awful.layout.suit.spiral.dwindle,
	-- awful.layout.suit.max.fullscreen,
	-- awful.layout.suit.magnifier
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
	for s = 1, screen.count() do
		gears.wallpaper.centered(beautiful.wallpaper, s)
	end
end
-- }}}

-- {{{ Tags
-- Provide tag names and layout settings if we wish to define them
tags = {}
for s = 1, screen.count() do
	tags[s] = { name = {}, layout = {} }
end
-- screen 1
--tags[1].name = {
--	[1] = '1:browser',
--	[2] = '2:terminal',
--	[3] = '3:terminal',
--	[4] = '4:float',
--	[9] = '9:mail'
--}
tags[1].layout = {
	[1] = layouts[2],
	[4] = layouts[1],
	[5] = layouts[1]
}
-- screens 2+
if screen.count() >= 2 then
	--tags[2].name = {
	--	[3] = '3:float',
	--}
	tags[2].layout = {
		[3] = layouts[1]
	}
end
-- Fill the missing values with defaults
for s = 1, screen.count() do
	for tag = 1, 9 do
		tags[s].name[tag] = tags[s].name[tag] or tag
		tags[s].layout[tag] = tags[s].layout[tag] or layouts[3]
	end
end
-- Set tags instances in wm
for s = 1, screen.count() do
	tags[s] = awful.tag(tags[s].name, s, tags[s].layout)
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
restartmenu = {
	{ 'restart', awesome.restart }
}
quitmenu = {
	{ 'quit', awesome.quit }
}

mymainmenu = awful.menu({
	items = {
		{ 'restart', restartmenu, beautiful.awesome_icon },
		{ 'quit', quitmenu, beautiful.awesome_icon }
	}
})

mylauncher = awful.widget.launcher({
	image = beautiful.awesome_icon,
	menu = mymainmenu
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock('%a %d %H:%M')
mytextclock:set_font('Terminus Bold 11')
-- Create a mail notification widget
mytextbox = wibox.widget.textbox()
mytextbox:set_text('')
mytextbox:set_font('Terminus 9')
-- Create keyboard layout indicator widget
--mykblayout = wibox.widget.textbox()
--mykblayout:set_text('US')
--mykblayout:set_font('Terminus Bold 11')

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
	awful.button({ }, 1, awful.tag.viewonly),
	awful.button({ modkey }, 1, awful.client.movetotag),
	awful.button({ }, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, awful.client.toggletag),
	awful.button({ }, 5, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
	awful.button({ }, 4, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
	awful.button({ }, 1,
		function (c)
			if c ~= client.focus then
				-- Without this, the following
				-- :isvisible() makes no sense
				c.minimized = false
				if not c:isvisible() then
					awful.tag.viewonly(c:tags()[1])
				end
				-- This will also un-minimize
				-- the client, if needed
				client.focus = c
				c:raise()
			end
		end),
	awful.button({ }, 3,
		function ()
			if instance then
				instance:hide()
				instance = nil
			else
				instance = awful.menu.clients({ width=250 })
			end
		end),
	awful.button({ }, 4,
		function ()
			awful.client.focus.byidx(1)
			if client.focus then
				client.focus:raise()
			end
		end),
	awful.button({ }, 5,
		function ()
			awful.client.focus.byidx(-1)
			if client.focus then
				client.focus:raise()
			end
		end)
)

for s = 1, screen.count() do
	-- Create a promptbox for each screen
	mypromptbox[s] = awful.widget.prompt()
	-- Create an imagebox widget which will contains an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	mylayoutbox[s] = awful.widget.layoutbox(s)
	mylayoutbox[s]:buttons(
		awful.util.table.join(
			awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
			awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
			awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
			awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)
		)
	)
	-- Create a taglist widget
	mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.noempty, mytaglist.buttons)

	-- Create a tasklist widget
	mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

	-- Create the wibox
	mywibox[s] = awful.wibox({ position = 'top', height = '16', screen = s })

	local left_layout = wibox.layout.fixed.horizontal()
	local right_layout = wibox.layout.fixed.horizontal()
	if s == 1 then
		left_layout:add(mytextbox)
		right_layout:add(mypromptbox[s])
		right_layout:add(mytaglist[s])
		if screen.count() == 1 then
			right_layout:add(wibox.widget.systray())
			right_layout:add(mytextclock)
		end
		right_layout:add(mylayoutbox[s])
	elseif s == 2 then
		left_layout:add(mylayoutbox[s])
		left_layout:add(mytextclock)
		left_layout:add(wibox.widget.systray())
		left_layout:add(mytaglist[s])
		left_layout:add(mypromptbox[s])
	else
		left_layout:add(mytaglist[s])
		left_layout:add(mypromptbox[s])
		right_layout:add(mylayoutbox[s])
	end

	-- Now bring it all together (with the tasklist in the middle)
	local layout = wibox.layout.align.horizontal()
	layout:set_left(left_layout)
	layout:set_middle(mytasklist[s])
	layout:set_right(right_layout)

	mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(
	awful.util.table.join(
		awful.button({ }, 3, function () mymainmenu:toggle() end),
		awful.button({ }, 5, awful.tag.viewnext),
		awful.button({ }, 4, awful.tag.viewprev)
	)
)
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
	awful.key({ modkey,           }, 'Up',     function () awful.screen.focus_relative( 1) end),
	awful.key({ modkey,           }, 'Down',   function () awful.screen.focus_relative(-1) end),
	awful.key({ modkey,           }, 'Left',   awful.tag.viewprev),
	awful.key({ modkey,           }, 'Right',  awful.tag.viewnext),
	awful.key({ modkey,           }, 'Escape', awful.tag.history.restore),

	-- Switch between windows
	awful.key({ modkey,           }, 'j', function () awful.client.focus.byidx(1) client.focus:raise() end),
	awful.key({ modkey,           }, 'k', function () awful.client.focus.byidx(-1) client.focus:raise() end),
	awful.key({ modkey,           }, 'i', function () client.focus:raise() end),
	awful.key({ modkey,           }, 'w', function () mymainmenu:show() end),

	-- Layout manipulation
	awful.key({ modkey, 'Shift'   }, 'j', function () awful.client.swap.byidx(1) end),
	awful.key({ modkey, 'Shift'   }, 'k', function () awful.client.swap.byidx(-1) end),
	awful.key({ modkey, 'Control' }, 'j', function () awful.screen.focus_relative(1) end),
	awful.key({ modkey, 'Control' }, 'k', function () awful.screen.focus_relative(-1) end),
	awful.key({ modkey,           }, 'u', awful.client.urgent.jumpto),

	-- Mod#+Tab hotkeys
	awful.key({ modkey,           }, 'Tab',
		function ()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end),
	awful.key({ 'Mod1',           }, 'Tab',
		function ()
			awful.client.focus.byidx(-1)
			if client.focus then
				client.focus:raise()
			end
		end),
	awful.key({ 'Mod1', 'Shift'   }, 'Tab',
		function ()
			awful.client.focus.byidx(1)
			if client.focus then
				client.focus:raise()
			end
		end),

	awful.key({ modkey,           }, 'l',     function () awful.tag.incmwfact(0.05)                       end),
	awful.key({ modkey,           }, 'h',     function () awful.tag.incmwfact(-0.05)                      end),
	awful.key({ modkey, 'Shift'   }, 'h',     function () awful.tag.incnmaster(1)                         end),
	awful.key({ modkey, 'Shift'   }, 'l',     function () awful.tag.incnmaster(-1)                        end),
	awful.key({ modkey, 'Control' }, 'h',     function () awful.tag.incncol(1)                            end),
	awful.key({ modkey, 'Control' }, 'l',     function () awful.tag.incncol(-1)                           end),
	awful.key({ modkey,           }, 'f',     function () awful.layout.set(awful.layout.suit.float)       end),
	awful.key({ modkey,           }, 'm',     function () awful.layout.set(awful.layout.suit.max)         end),
	awful.key({ modkey,           }, 't',
		function ()
			if awful.layout.get(mouse.screen) == awful.layout.suit.tile.bottom then
				awful.layout.set(awful.layout.suit.tile)
			else
				awful.layout.set(awful.layout.suit.tile.bottom)
			end
		end),

	awful.key({ modkey, 'Control' }, 'n',     awful.client.restore),

	-- Prompt
	awful.key({ modkey,           }, 'r',     function () mypromptbox[mouse.screen]:run() end),
	awful.key({ 'Mod1',           }, 'F2',    function () mypromptbox[mouse.screen]:run() end),

	awful.key({ modkey,           }, 'e',
		function ()
			awful.prompt.run(
				{ prompt = 'Run Lua code: ' },
				mypromptbox[mouse.screen].widget,
				awful.util.eval, nil,
				awful.util.getdir('cache') .. '/history_eval'
			)
		end),
	-- Menubar
	awful.key({ modkey,           }, 'p',     function () menubar.show() end),
	-- Glbal commands
	awful.key({ modkey,           }, 'x',     function () awful.util.spawn(terminal) end),
	awful.key({ modkey,           }, 'q',     function () awful.util.spawn('/home/von/.local/bin/ticket_watch', false) end),
	awful.key({ modkey,           }, 'z',     function () awful.util.spawn('bash -c "until slock; do :; done"') end),
	awful.key({ modkey,           }, 'F6',    function () awful.util.spawn('/home/von/touchpad_hotkey.sh', false) end),
	awful.key({                   }, 'Print', function () awful.util.spawn('xfce4-screenshooter -ws /home/von/screenshots') end),
	awful.key({ modkey,           }, 'Print', function () awful.util.spawn('xfce4-screenshooter -fs /home/von/screenshots') end)
)

clientkeys = awful.util.table.join(
	awful.key({ 'Mod1',           }, 'Return', function (c) c.fullscreen = not c.fullscreen  end),
	awful.key({ modkey, 'Shift'   }, 'c',      function (c) c:kill()                         end),
	awful.key({ modkey, 'Shift'   }, 'f',      awful.client.floating.toggle                     ),
	awful.key({ modkey,           }, 'Return', function (c) c:swap(awful.client.getmaster()) end),
	awful.key({ modkey,           }, 'o',      awful.client.movetoscreen                        ),
	awful.key({ modkey, 'Shift'   }, 't',      function (c) c.ontop = not c.ontop            end),
	awful.key({ modkey, 'Shift'   }, 's',      function (c) c.sticky = not c.sticky          end),
	awful.key({ modkey,           }, 'n',      function (c) c.minimized = true               end),
	awful.key({ modkey, 'Shift'   }, 'm',
		function (c)
			c.maximized_horizontal = not c.maximized_horizontal
			c.maximized_vertical   = not c.maximized_vertical
			if c.maximized_horizontal == true and c.maximized_vertical == true then
				c.border_width = 0
				client.focus:raise()
			else
				c.border_width = beautiful.border_width
			end
		end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = awful.util.table.join(globalkeys,
		awful.key({ modkey }, '#' .. i + 9,
			function ()
				local screen = mouse.screen
				local tag = awful.tag.gettags(screen)[i]
				if tag then
					awful.tag.viewonly(tag)
				end
			end),
		awful.key({ modkey, 'Control' }, '#' .. i + 9,
			function ()
				local screen = mouse.screen
				local tag = awful.tag.gettags(screen)[i]
				if tag then
					awful.tag.viewtoggle(tag)
				end
			end),
		awful.key({ modkey, 'Shift' }, '#' .. i + 9,
			function ()
				if client.focus then
					local tag = awful.tag.gettags(client.focus.screen)[i]
					if tag then
						awful.client.movetotag(tag)
					end
				end
			end),
		awful.key({ modkey, 'Control', 'Shift' }, '#' .. i + 9,
			function ()
				if client.focus then
					local tag = awful.tag.gettags(client.focus.screen)[i]
					if tag then
						awful.client.toggletag(tag)
					end
				end
			end)
	)
end

clientbuttons = awful.util.table.join(
	awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
	awful.button({ modkey }, 1, awful.mouse.client.move),
	awful.button({ modkey }, 3, awful.mouse.client.resize)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = { },
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			keys = clientkeys,
			buttons = clientbuttons
		}
	},
	-- Floating only rules class based rules
	{
		rule_any = {
			class = {
				'Deadbeef',
				'Google-musicmanager',
				'mpv',
				'Pavucontrol',
				'Pidgin',
				'pinentry',
				'plugin-container',
				'Qmmp',
				'Skype',
				'Vncviewer'
			},
			instance = {
				'sun-awt-X11-XFramePeer'
			}
		},
		properties = {
			floating = true
		}
	},
	-- Mostly floating rules, we want to keep them separately since it's easier to manage
	-- firefox
	{
		rule = { class = 'Firefox' },
		except = { instance = 'Navigator' },
		properties = { floating = true }
	},
	-- ardour3
	{
		rule = { class = 'Ardour' },
		except = { instance = 'ardour_editor' },
		properties = { floating = true }
	},
	-- Remove gaps between terminal windows:
	-- roxterm
	{
		rule = { class = 'Roxterm' },
		properties = { size_hints_honor = false }
	},
	-- Specific desktops rules: place windows only on specific tags by default
	-- steam
	{
		rule_any = {
			class = { 'Steam' },
			instance = { 'Steam.exe' }
		},
		properties = { tag = tags[1][4] }
	},
	-- games = float / fullscreen
	{
		rule_any = {
			class = {
				'Awesomenauts.bin.x86',
				'Civ5XP',
				'ck2',
				'csgo_linux',
				'deponia_tcj',
				'dota_linux',
				'game.x86_64',
				'hl2_linux',
				'Pandora',
				'Strife',
				'Symphony.bin.x86_64',
				'witcher2'
			},
			instance = {
				'Civ4BeyondSword.exe',
				'KB.exe',
				'nwn2main.exe'
			},
			name = {
				'Hand of Fate',
				'Serious Sam 3 - Linux'
			}
		},
		properties = {
			border_width = 0,
			floating = true,
			tag = tags[1][5]
		}
	},
	-- games = maximized
	{
		rule_any = {
			instance = {
				'BGEE.exe',
				'Baldur.exe'
			}
		},
		properties = {
			border_width = 0,
			tag = tags[1][2]
		}
	}
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal(
	'manage',
	function (c, startup)
		-- Enable sloppy focus
		c:connect_signal(
			'mouse::enter',
			function(c)
				if (awful.layout.get(c.screen) ~= awful.layout.suit.magnifier and awful.layout.get(c.screen) ~= awful.layout.suit.floating) and awful.client.focus.filter(c) then
					client.focus = c
				end
			end
		)

		if not startup then
			-- Set the windows at the slave,
			-- i.e. put it at the end of others instead of setting it master.
			-- awful.client.setslave(c)

			-- Put windows in a smart way, only if they do not set an initial position.
			if not c.size_hints.user_position and not c.size_hints.program_position then
				awful.placement.no_overlap(c)
				awful.placement.no_offscreen(c)
			end
		end
	end
)

client.connect_signal('focus', function(c) c.border_color = beautiful.border_focus end)
client.connect_signal('unfocus', function(c) c.border_color = beautiful.border_normal end)
-- }}}
-- {{{ Autostart
-- don't forget you sync this file
-- this shit runs every time you restart your wm, dumbass.
awful.util.spawn_with_shell('setxkbmap -layout us,ru -variant altgr-intl,typewriter -option grp:caps_toggle,grp:win_space_toggle,compose:menu,grp_led:scroll')
awful.util.spawn_with_shell('xrdb /home/von/.Xresources')
if ifexists('/home/von/.autostart') then
	awful.util.spawn_with_shell('/home/von/.autostart')
end
-- }}}
