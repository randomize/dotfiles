-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Menu --
local xdg_menu = require("archmenu")
-- More widgets --
local vicious = require("vicious")
-- Scratchdrop (to toggle terminals and other things)
local drop = require("scratchdrop")
-- Custom Widgets
-- local custom_widgets = {
--     kbdd = require("widgets.kbdd"),
-- }

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

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
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Config location, many things will rely on this path
local config_dir_path = awful.util.getdir("config")
local home_dir_path = os.getenv("HOME")
local mod4func_path = home_dir_path .. "/bin/mod4func.sh "
local log_notificatin_path = home_dir_path .. "/scripts/log_notification"
local notiy_sound_path = config_dir_path .. "/notify.wav"
local zenburn_theme_path = config_dir_path .. "/zenburn/theme.lua"


-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.init(zenburn_theme_path)

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
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
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Notifications hook that logs messages
naughty.config.notify_callback = function(args)
    local tit = args.title
    if tit == "Volume" or 
       tit == "MPD player" or
       (tit and (string.match(tit, "Playing #") or (string.match(tit, "Paused #")) ))
       then return args end
    awful.spawn( log_notificatin_path .. " '" .. (args.title or "") .. "' '" .. args.text .. "'")
    awful.spawn("paplay " .. notiy_sound_path, false);
    return args
end
-- }}}

-- {{{ Helper functions

-- drops terminal
local function drop_terminal()
    local center_screen = awful.screen.getbycoord (1024, 720)
    drop("alacritty --class my_floating_terminal -e ~/bin/starttmux.sh", "center", "center", 0.8, 0.8, true, center_screen)
end

local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- helper that wraps widgets
local function only_on_primary(wid)
    local wibox = require("wibox")
    local awful = { widget = { only_on_screen = require("awful.widget.only_on_screen") } }

    return { { widget = wid, },
        screen = "primary",
        widget = awful.widget.only_on_screen
    }
end
-- helper to control volume with keyboard knob
local vol_notification_id;
function change_volume(op)

   local fd = io.popen("amixer sset Master " .. op)
   local out = fd:read("*all")
   fd:close()

   local vol = string.match(out, "(%d+)%%")
   local status = string.match(out, "%[(o[^%]]*)%]")

   if not string.find(status, "on", 1, true) then
       vol = " Volume is : " .. vol .. "% (Muted)"
       vol_notification_id = naughty.notify({ title = "Volume", text = vol , timeout = 10, replaces_id = vol_notification_id }).id
   else
       vol = " Volume is : " .. vol .. "%"
       vol_notification_id = naughty.notify({ title = "Volume", text = vol , timeout = 10, replaces_id = vol_notification_id }).id
   end
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({ items = { { "Awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "Open terminal", terminal },
                                    { "Applications", xdgmenu },
                                    { "MyPaint", "mypaint" },
                                    { "Firefox", "firefox" },
                                    { "Firefox Incognito", "firefox --new-instance -P trash" },
                                    { "qBittorrent", "qbittorrent" },
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Awesomd widget
local awesompd = require('awesompd/awesompd')

musicwidget = awesompd:create() -- Create awesompd widget
musicwidget.font = "PragmataPro"
musicwidget.font_color = beautiful.fg_normal
musicwidget.background = beautiful.bg_normal
musicwidget.scrolling = true -- If true, the text in the widget will be scrolled
musicwidget.output_size = 30 -- Set the size of widget in symbols
musicwidget.update_interval = 1 -- Set the update interval in seconds

-- Set the folder where icons are located
musicwidget.path_to_icons = config_dir_path .. "/awesompd/icons"

-- Set the path to the icon to be displayed on the widget itself
musicwidget.widget_icon = config_dir_path .. "/awesompd/icons/radio_icon.png"

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
musicwidget.mpd_config =  "~/.config/mpd/mpd.conf"

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

-- }}}


-- {{{ Wibar

-- Keyboard map indicator and switcher
-- mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a network widget
netwidget = wibox.widget.textbox()
vicious.register(netwidget, vicious.widgets.net, '<span color="#CC9393"> ${enp3s0 down_kb}</span> <span color="#7F9F7F">${enp3s0 up_kb}</span>', 3)
netwidget = only_on_primary(netwidget)

-- Create a mem widget
memwidget = wibox.widget.textbox()
vicious.register(memwidget, vicious.widgets.mem, "<span color='#CCCC11'> $1% </span>", 13)
memwidget = only_on_primary(memwidget)
-- vicious.register(memwidget, vicious.widgets.mem, "<span color='#CCCC11'> $1% ($2MB/$3MB)</span>", 13)

-- CPU Graph
cpuwidget = awful.widget.graph()
cpuwidget:set_width(100)
cpuwidget:set_background_color(beautiful.bg_normal)
cpuwidget:set_color({ type = "linear", from = { 0, 0 }, to = { 10,0 }, stops = { {0, "#FF5656"}, {0.5, "#88A175"}, {1, "#AECF96" }}})
vicious.register(cpuwidget, vicious.widgets.cpu, "$1")
cpuwidget = only_on_primary(cpuwidget)

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.

    awful.tag({"α", "β", "γ", "δ", "ε", "ζ", "η", "θ", "ι", "κ", "λ", "hidden" }, s, awful.layout.layouts[4])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    local function filter(t) 
        return t.name ~= "hidden" 
    end 
    s.mytaglist = awful.widget.taglist(s, filter, taglist_buttons) 
    --s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            cpuwidget,
            netwidget,
            memwidget,
            musicwidget.widget,
            -- mykeyboardlayout,
            -- custom_widgets.kbdd(),
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
        },
    }
end)

-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "a", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "d", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Shift"   }, "o", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () drop_terminal() end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Shift"   }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey, "Shift" }, "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),
    -- Screenshots
    awful.key({                   }, "Print",
      function ()
         awful.spawn.with_shell("maim ~/shot_$(date +%+4Y-%b-%d-%H-%M-%S).png", false)
         naughty.notify({ title="Screenshot", text="Capturing full screen" })
      end,
      {description = "take screenshot", group = "launcher"}),
    awful.key({ "Shift"         }, "Print",
      function ()
         awful.spawn.with_shell("maim -u -s ~/shot_$(date +%+4Y-%b-%d-%H-%M-%S).png", false)
         naughty.notify({ title="Screenshot", text="Capturing an area" })
      end,
      {description = "take area screenshot", group = "launcher"}),
    -- Misc soft
    awful.key({ modkey,           }, "e",
       function ()
          drop("kitty --title=Ranger --class=my_floating_ranger ranger ", "center", "center", 0.75, 0.75)
       end,
      {description = "launch ranger", group = "launcher"}),
    -- awful.key({ modkey, "Shift"}, "e",
    --    function ()
    --       awful.spawn("nautilus", false)
    --    end,
    --   {description = "launch nautilus", group = "launcher"}),
    awful.key({ modkey, "Shift"}, "n",
       function ()
          awful.spawn("~/bin/vnc-menu", false)
       end
    ),
    awful.key({ modkey,            }, "Up",
      function ()
         awful.spawn("rofi -modi combi -show combi -combi-modi run,drun")
      end
    ),
    awful.key({ modkey,           }, "b",
      function ()
         awful.spawn("rofipassmenu")
      end
    ),
    awful.key({ modkey, "Shift"   }, "b",
      function ()
         awful.spawn("stepmenu")
      end
    ),
    awful.key({ modkey, "Control"   }, "b",
      function ()
         awful.spawn("wordmenu")
      end
    ),

    -- Media keys mappings
    awful.key({                   }, "XF86AudioRaiseVolume", function () change_volume("1%+") end),
    awful.key({                   }, "XF86AudioLowerVolume", function () change_volume("1%-") end),
    awful.key({                   }, "XF86AudioMute", function () change_volume("toggle") end),
    awful.key({                   }, "XF86HomePage", function () awful.spawn("firefox") end),
    awful.key({                   }, "XF86Mail", function () awful.spawn("thunderbird") end),
    awful.key({                   }, "XF86Messenger", function () awful.spawn("pidgin") end),
    awful.key({                   }, "XF86Search", function () awful.spawn("chromium --incognito") end),
    awful.key({                   }, "XF86TaskPane", function () awful.spawn("chromium --incognito") end),

    awful.key({                   }, "XF86Eject", function ()
       drop("alacritty --class my_floating_htop -e htop", "center", "center", 0.7, 0.65, true)
    end),

    awful.key({ "Shift"           }, "XF86AudioPlay", function ()
       drop("alacritty --class my_floating_ncmpcpp -e ncmpcpp", "center", "center", 0.9, 0.85)
    end),

    awful.key({                   }, "XF86Calculator", function ()
         drop("alacritty --class my_floating_calculator -e python  -ic 'from math import *; from random import *'",
              "center", "center", 0.2, 0.1
         )
    end),

    awful.key({                   }, "XF86AudioPlay",
      function ()
         awful.spawn("mpc toggle", false)
         naughty.notify({ title="MPD player", text="Play / Pause" })
      end
    ),
    awful.key({                   }, "XF86AudioPrev",
      function ()
         awful.spawn("mpc prev", false)
         naughty.notify({ title="MPD player", text="Previous track" })
      end
    ),
    awful.key({                   }, "XF86AudioNext",
      function ()
         awful.spawn("mpc next", false)
         naughty.notify({ title="MPD player", text="Next track" })
      end
    ),
    awful.key({ "Shift"           }, "XF86AudioNext",
      function ()
         awful.spawn("mpc seek +0:0:5", false)
         naughty.notify({ title="MPD player", text="Seek forward" })
      end
    ),
    awful.key({ "Shift"           }, "XF86AudioPrev",
      function ()
         awful.spawn("mpc seek -0:0:5", false)
         naughty.notify({ title="MPD player", text="Seek backward" })
      end
    ),
    -- brightness (ddccontrol is broken)
    -- awful.key({ "Shift"           }, "XF86AudioRaiseVolume",
    --   function ()
    --      awful.spawn_with_shell("echo -n 'u' | socat - UDP-DATAGRAM:127.0.0.1:9930", false)
    --   end
    -- ),
    -- awful.key({ "Shift"           }, "XF86AudioLowerVolume",
    --   function ()
    --      awful.spawn_with_shell("echo -n 'd' | socat - UDP-DATAGRAM:127.0.0.1:9930", false)
    --   end
    -- ),
    awful.key({ modkey            }, "XF86AudioRaiseVolume",
      function () awful.layout.inc(layouts,  1) end
    ),
    awful.key({ modkey            }, "XF86AudioLowerVolume",
      function () awful.layout.inc(layouts, -1) end
    ),
    awful.key({                   }, "XF86Sleep",
      function ()
         awful.spawn("sudo pm-suspend", false)
      end
    ),
    awful.key({ "Shift"           }, "XF86Sleep",
      function ()
         awful.spawn("sudo poweroff", false)
      end
    )
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey,           }, "w",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 11 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

-- Bind mod+Fkey to screens
for i = 1, 4 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey, }, "F" .. i, function ()
            awful.screen.focus(i)
        end)
   )
end

clientbuttons = gears.table.join(
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
                     callback = function(c) c.maximized, c.maximized_vertical, c.maximized_horizontal = false, false, false end,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

     -- { rule = { class = "mpv" },
     --  properties = { focusable = false } },

    { rule = { class = "Conky" }, properties = { 
        floating = true, 
        focusable = false,
        skip_pager = true,
        skip_taskbar = true,
        focus = false,
        tag = "hidden",
        border_width = 0,
        --dockable = true 
    }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    { rule_any = { 
        instance = { "pinentry" },
        class = { "Zenity" },
        },
        properties = { floating = true },
        callback = function (c)
            awful.placement.centered(c,nil)
        end
    },

    { rule = { class = "chromium" },
          properties = { maximized = false, floating = false } 
    },

    -- Rider on main screen please
    { rule = { class = "jetbrains-rider"},
          properties = {
          maximized = true,
          screen = 1,
          floating = true } 
    },

}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
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

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
