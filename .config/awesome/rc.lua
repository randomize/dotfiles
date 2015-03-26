
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

-- {{{ Notifications handler
naughty.config.notify_callback = function(args)
    -- awful.util.spawn_with_shell("~/Scripts/notified awesome '" .. (args.title or "") .. "' '" .. args.text .. "'")
    awful.util.spawn("paplay " .. awful.util.getdir("config") .. "/notify.wav");
    return args
end
-- }}}

-- Menu --
xdg_menu = require("archmenu")

-- More widgets --
vicious = require("vicious")

-- Toggle terminals and other things
local drop      = require("scratchdrop")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(awful.util.getdir("config") .. "/zenburn/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "xterm"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}

local layouts_f_keys = { "F9", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F10", "F11", "F12" }
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags

-- Define a tag table which hold all screen tags.
namedtags = {
   names = {"α", "β", "γ", "δ", "ε", "ζ", "η", "θ", "ι", "κ", "λ" },
   layout = {layouts[2], layouts[2], layouts[2], layouts[2], layouts[4], layouts[2], layouts[1], layouts[1], layouts[2], layouts[2], layouts[2]}
}

-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    tags[s] = awful.tag(namedtags.names, s, namedtags.layout)
    awful.tag.setncol(2, tags[s][9])
    awful.tag.setproperty(tags[s][9], "mwfact", 0.20)
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "Awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "Applications", xdgmenu },
                                    { "Open terminal", terminal },
                                    { "Firefox", "firefox" },
                                    { "Gvim", "gvim" },
                                    { "Android Studio", "android-studio" },
                                    { "Chromium", "chromium" }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock()

-- Create a network widget
netwidget = wibox.widget.textbox()
vicious.register(netwidget, vicious.widgets.net, '<span color="#CC9393"> ${enp3s0 down_kb}</span> <span color="#7F9F7F">${enp3s0 up_kb}</span>', 3)

-- Create a mem widget
memwidget = wibox.widget.textbox()
vicious.register(memwidget, vicious.widgets.mem, "<span color='#CCCC11'> $1% </span>", 13)
-- vicious.register(memwidget, vicious.widgets.mem, "<span color='#CCCC11'> $1% ($2MB/$3MB)</span>", 13)

-- CPU Graph
cpuwidget = awful.widget.graph()
cpuwidget:set_width(50)
cpuwidget:set_background_color("#494B4F")
cpuwidget:set_color({ type = "linear", from = { 0, 0 }, to = { 10,0 }, stops = { {0, "#FF5656"}, {0.5, "#88A175"}, {1, "#AECF96" }}})
vicious.register(cpuwidget, vicious.widgets.cpu, "$1")


-- Awesome MPD widget

local awesompd = require('awesompd/awesompd')

musicwidget = awesompd:create() -- Create awesompd widget
musicwidget.font = "PragmataPro" -- Set widget font
musicwidget.font_color = "#EEEEEE" --Set widget font color
-- musicwidget.background = "#000000" --Set widget background color
musicwidget.scrolling = true -- If true, the text in the widget will be scrolled
musicwidget.output_size = 30 -- Set the size of widget in symbols
musicwidget.update_interval = 3 -- Set the update interval in seconds

-- Set the folder where icons are located
musicwidget.path_to_icons = "/home/randy/.config/awesome/awesompd/icons"

-- Set the path to the icon to be displayed on the widget itself
-- musicwidget.widget_icon = "/path/to/icon"

-- Set the default music format for Jamendo streams. You can change
-- this option on the fly in awesompd itself.
-- possible formats: awesompd.FORMAT_MP3, awesompd.FORMAT_OGG
musicwidget.jamendo_format = awesompd.FORMAT_MP3

-- Specify the browser you use so awesompd can open links from
-- Jamendo in it.
musicwidget.browser = "firefox"

-- If true, song notifications for Jamendo tracks and local tracks
-- will also contain album cover image.
musicwidget.show_album_cover = true

-- Specify how big in pixels should an album cover be. Maximum value
-- is 100.
musicwidget.album_cover_size = 64

-- This option is necessary if you want the album covers to be shown
-- for your local tracks.
musicwidget.mpd_config = "/home/randy/.config/mpd/mpd.conf"

-- Specify decorators on the left and the right side of the
-- widget. Or just leave empty strings if you decorate the widget
-- from outside.
musicwidget.ldecorator = ""
musicwidget.rdecorator = ""

-- Set all the servers to work with (here can be any servers you use)
musicwidget.servers = {
   { server = "localhost",
     port = 6600 }
}

-- Set the buttons of the widget. Keyboard keys are working in the
-- entire Awesome environment. Also look at the line 352.
musicwidget:register_buttons(
   { { "", awesompd.MOUSE_LEFT, musicwidget:command_playpause() },
     { "Control", awesompd.MOUSE_SCROLL_UP, musicwidget:command_prev_track() },
     { "Control", awesompd.MOUSE_SCROLL_DOWN, musicwidget:command_next_track() },
     { "", awesompd.MOUSE_SCROLL_UP, musicwidget:command_volume_up() },
     { "", awesompd.MOUSE_SCROLL_DOWN, musicwidget:command_volume_down() },
     { "", awesompd.MOUSE_RIGHT, musicwidget:command_show_menu() },
--     { "", "XF86AudioLowerVolume", musicwidget:command_volume_down() },
--     { "", "XF86AudioRaiseVolume", musicwidget:command_volume_up() },
     { modkey, "Pause", musicwidget:command_playpause() } })

musicwidget:run() -- After all configuration is done, run the widget

-- END OF AWESOMPD WIDGET DECLARATION
-- Don't forget to add the widget to the wibox. It is done on the line 244.


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
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
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
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({
                                                      theme = { width = 250 }
                                                  })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()

    -- right_layout:add(mpdwidget)
    right_layout:add(mytextclock)
    if s == 1 then 
        right_layout:add(cpuwidget)
        right_layout:add(netwidget)
        right_layout:add(memwidget)
        right_layout:add(musicwidget.widget)
        right_layout:add(wibox.widget.systray()) 
    end

    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Volume control functions

local vol_notification_id;
function change_volume(op)

   local fd = io.popen("amixer sset Master " .. op)
   local out = fd:read("*all")
   fd:close()

   local vol = string.match(out, "(%d+)%%")
   local status = string.match(out, "%[(o[^%]]*)%]")

   if not string.find(status, "on", 1, true) then
       vol = " Volume is : " .. vol .. "% (Muted)"
       vol_id = naughty.notify({ title = "Volume", text = vol , timeout = 10, replaces_id = vol_id }).id
   else
       vol = " Volume is : " .. vol .. "%"
       vol_id = naughty.notify({ title = "Volume", text = vol , timeout = 10, replaces_id = vol_id }).id
   end
end

-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "l", function () awful.tag.incmwfact( 0.05)      end),
    awful.key({ modkey,           }, "h", function () awful.tag.incmwfact(-0.05)      end),
    awful.key({ modkey, "Shift"   }, "h", function () awful.tag.incnmaster( 1)        end),
    awful.key({ modkey, "Shift"   }, "l", function () awful.tag.incnmaster(-1)        end),
    awful.key({ modkey, "Control" }, "h", function () awful.tag.incncol( 1)           end),
    awful.key({ modkey, "Control" }, "l", function () awful.tag.incncol(-1)           end),


    -- Call awesome menu
    awful.key({ modkey,           }, "d", function () mymainmenu:show() end),

    -- Urgent window
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),

    -- Restore
    awful.key({ modkey, "Control" }, "n", awful.client.restore),


    -- Windows and workspace switch
    awful.key({ modkey,           }, "a", awful.tag.history.restore),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- {{{ Standard programs launch

    awful.key({ modkey,           }, "e",
       function ()
          --drop("urxvtc -depth 0 -name my_floating_ranger -e ranger ", "top", "center", 1, 0.5)
          drop("xterm -e ranger ", "top", "center", 1, 0.5)
       end
    ),
    awful.key({ modkey, "Shift"}, "e",
       function ()
          awful.util.spawn("nautilus", false)
       end
    ),

    -- Screenshots
    awful.key({                   }, "Print",
      function ()
         awful.util.spawn("escrotum", false)
         naughty.notify({ title="Screenshot", text="Capturing full screen" })
      end),
    awful.key({ "Control"         }, "Print",
      function ()
         awful.util.spawn("escrotum -s", false)
         naughty.notify({ title="Screenshot", text="Capturing a window" })
      end
    ),

    -- Media keys
    awful.key({                   }, "XF86HomePage", function () awful.util.spawn("firefox") end),
    awful.key({                   }, "XF86Mail", function () awful.util.spawn("thunderbird") end),
    awful.key({                   }, "XF86Messenger", function () awful.util.spawn("pidgin") end),
    awful.key({                   }, "XF86Search", function () awful.util.spawn("chromium --incognito") end),
    awful.key({                   }, "XF86TaskPane", function () awful.util.spawn("chromium --incognito") end),
    awful.key({                   }, "XF86AudioRaiseVolume", function () change_volume("5%+") end),
    awful.key({                   }, "XF86AudioLowerVolume", function () change_volume("5%-") end),
    awful.key({                   }, "XF86AudioMute", function () change_volume("toggle") end),

    awful.key({                   }, "XF86Eject", function ()
       drop("urxvtc -name my_floating_htop -e htop -d 2", "center", "center", 0.7, 0.65, true)
    end),

    awful.key({                   }, "XF86Tools", function ()
       drop("urxvtc -name my_floating_ncmpcpp -geometry 64x210+0+0 -e ncmpcpp", "center", "center", 0.9, 0.85)
    end),

    awful.key({                   }, "XF86Calculator", function ()
         drop("urxvtc -name my_floating_calculator -geometry 100x20+0+0 -fg white -e python  -ic 'from math import *; from random import *'",
              "center", "center", 0.2, 0.1
         )
    end),

    awful.key({                   }, "XF86AudioPlay",
      function ()
         awful.util.spawn("mpc toggle", false)
         naughty.notify({ title="MPD player", text="Play / Pause" })
      end
    ),
    awful.key({                   }, "XF86AudioPrev",
      function ()
         awful.util.spawn("mpc prev", false)
         naughty.notify({ title="MPD player", text="Previous track" })
      end
    ),
    awful.key({                   }, "XF86AudioNext",
      function ()
         awful.util.spawn("mpc next", false)
         naughty.notify({ title="MPD player", text="Next track" })
      end
    ),
    awful.key({ "Shift"           }, "XF86AudioNext",
      function ()
         awful.util.spawn("mpc seek +0:0:5", false)
         naughty.notify({ title="MPD player", text="Seek forward" })
      end
    ),
    awful.key({ "Shift"           }, "XF86AudioPrev",
      function ()
         awful.util.spawn("mpc seek -0:0:5", false)
         naughty.notify({ title="MPD player", text="Seek backward" })
      end
    ),
    -- }}}

    -- Awesome control
    awful.key({ modkey, "Shift"   }, "c", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    -- Terminals
    awful.key({ modkey,           }, "Return",
       function ()
          --if client.focus.screen == 1 then
          --   drop("urxvtc -fn \"xft:Pragmata Pro:pixelsize=16\" -name my_floating_terminal -e /home/randy/bin/starttmux.sh", "center", "center", 0.9, 0.9, true)
          --else
             drop("urxvtc -name my_floating_terminal -e /home/randy/bin/starttmux.sh", "center", "center", 0.7, 0.65, true)
          --end
       end
    ),
    awful.key({ modkey, "Shift"   }, "Return",
       function ()
          -- awful.util.spawn("xterm")
          awful.util.spawn("urxvtc")
       end
    ),

    -- Swithing layouts
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Prompt
    awful.key({ modkey            }, "r",     function () mypromptbox[mouse.screen]:run() end),
    awful.key({ modkey, "Shift"   }, "r",
      function ()
         awful.util.spawn("dmenu_run -l 32 -fn \"PragmataPro-11:bold\" -b -q -z -o 0.90 -p \"$\" ")
      end
    ),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(

    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,           }, "w",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),

    -- Minimize
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),

    -- Toggle maximize
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 10 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

-- Bind all key numbers to tags.
for i = 1, 12 do
    globalkeys = awful.util.table.join(globalkeys,
        -- Swithch layout
        awful.key({ modkey, "Control" }, layouts_f_keys[i], function () awful.layout.set(layouts[i]) end)
   )
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))


musicwidget:append_global_keys()
-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     -- floating = false,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    -- Conky special window
    { rule = { class = "Conky" },
     properties = {
         floating = true,
         sticky = true,
         ontop = false,
         focusable = false,
         raise = false,
         size_hints = {"program_position", "program_size"}
     }
    },
    -- Floating centered windows by class
    { rule_any = { class = { "pinentry", "Xmessage", "feh", "screekey" }},
       properties = { floating = true },
       callback = function (c) awful.placement.centered(c,nil) end
    },
    -- Floating windows by class
    { rule_any = { class = { "gimp", "Xsane", "Qjackctl", "Screenkey"}},
       properties = { floating = true }
    },
    -- Guake-like drops
    { rule_any = { class = { "my_floating_ranger", "my_floating_htop", "my_floating_ncmpcpp",
                             "my_floating_calculator", "my_floating_terminal"},
                   instance = { "my_floating_terminal" } },
      properties = { floating = true, skip_taskbar = true, above = true },
      callback = function (c) awful.placement.centered(c,nil) end
    },
    -- Set Firefox to always map on tags number 1 of screen 1.
    { rule = { class = "Firefox" }, properties = {   tag = tags[2][1], }, },
    -- Set Pidgin
    -- { rule = { class = "Pidgin", role = "buddy_list"},
      -- properties = { tag = tags[1][9] } },
    -- { rule = { class = "Pidgin", role = "conversation"},
      -- properties = { tag = tags[1][9]}, callback = awful.client.setslave },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
            awful.placement.centered(c,nil)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

