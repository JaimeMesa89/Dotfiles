-- MONITORS
hl.monitor({
  output = "DP-1",
  mode = "1920x1080@144",
  position = "0x0",
  scale = 1,
})

hl.monitor({
  output = "HDMI-A-1",
  mode = "1920x1080@60",
  position = "1920x0",
  scale = 1,
})


-- WORKSPACES
hl.workspace_rule({
  workspace = "1",
  monitor = "DP-1",
  default = true,
})


-- MY PROGRAMS

local terminal = "kitty"
local tuiFileManager = "kitty -e zsh -ic 'y; zsh'"
local notes = "kitty -e zsh -ic 'cd '$HOME/Documents/Notes/' && y; zsh'"
local rss = "kitty -e zsh -ic 'newsraft; zsh'"
local guiFileManager = "thunar"
local menu = "wofi --show drun --style ~/.config/wofi/style.css"
local browser = "firefox"



-- AUTOSTART

hl.on("hyprland.start", function()
  hl.exec_cmd("~/.config/waybar/waybar.sh")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("[ workspace special:mixer silent ] kitty -e wiremix")
end)


-- ENVIRONMENT
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("GTK_THEME", "Materia-dark")


-- LOOK AND FEEL
hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 20,

    border_size = 2,

    col = {
      active_border = "rgb(CDB58F)",
      inactive_border = "rgba(595959aa)",
    },

    allow_tearing = false,

    layout = "dwindle",
  },

  decoration = {
    rounding = 10,

    active_opacity = 1.0,
    inactive_opacity = 1.0,

    shadow = {
      enabled = false,
    },

    blur = {
      enabled = false,
    },
  },

  animations = {
    enabled = false,
  },

  dwindle = {
    preserve_split = true,
    force_split = 2,
  },

  input = {
    kb_layout = "us, es",
    kb_options = "grp:win_space_toggle",
    follow_mouse = 1,
    mouse_refocus = true,
    sensitivity = 0,
  },

  cursor = {
    default_monitor = "DP-1"
  }

})


-- KEYBINDINGS
local mainMod = "SUPER"
-- General
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("hyprpicker --autocopy"))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(tuiFileManager))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(guiFileManager))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(notes))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(rss))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("guiFileManager"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

hl.bind(mainMod .. " + H",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))

--hl.bind( mainMod .. " + Tab", hl.dsp.workspace("previous"))

for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end


-- Special Workspaces
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + M", hl.dsp.workspace.toggle_special("mixer"))

-- Mouse
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


-- Screenshot
hl.bind(mainMod .. " + grave", hl.dsp.exec_cmd("/home/junk/.config/hypr/scripts/screenshot.sh"))
hl.bind(mainMod .. " + SHIFT + grave", hl.dsp.exec_cmd("/home/junk/.config/hypr/scripts/screenshot.sh -s"))

-- Hyprsunset
hl.bind(mainMod .. " + delete", hl.dsp.exec_cmd("/home/junk/.config/hypr/scripts/toggle-hyprsunset.sh"))


-- WINDOWRULES
hl.window_rule({
  name = "suppress-maximize-events",
  match = {
    class = ".*",
  },
  suppress_event = "maximize",
})

hl.window_rule({
  name = "fix-xwayland-drags",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },
  no_focus = true,
})

hl.window_rule({
  name = "blender-file-view",
  match = {
    class = "blender",
    float = true,
  },
  float = true,
  center = true,
  size = "1200 800",
})

-- Hyprland-run windowrule
hl.window_rule({
  name = "move-hyprland-run",
  match = {
    class = "hyprland-run",
  },
  move = "20 monitor_h-120",
  float = true,
})

-- MISC
--hl.set("ecosystem:no_update_news", true)

-- Graphic Tablet
-- hl.device("wacom-one-by-wacom-m-pen", {
--   output = "DP-1",
--   left_handed = true,
-- })
