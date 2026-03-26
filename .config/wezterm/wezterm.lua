local wezterm = require("wezterm")
local act = wezterm.action

wezterm.on("gui-startup", function()
  local _, _, window = wezterm.mux.spawn_window({})
  window:gui_window():maximize()
end)

return {
  font = wezterm.font("Hack Nerd Font Mono"),
  color_scheme = "Tokyo Night",
  window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
  },
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,

  keys = {
    { key = "d", mods = "CMD", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "d", mods = "CMD|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "w", mods = "CMD|OPT", action = act.CloseCurrentPane({ confirm = false }) },

    { key = "h", mods = "CMD|OPT", action = act.ActivatePaneDirection("Left") },
    { key = "j", mods = "CMD|OPT", action = act.ActivatePaneDirection("Down") },
    { key = "k", mods = "CMD|OPT", action = act.ActivatePaneDirection("Up") },
    { key = "l", mods = "CMD|OPT", action = act.ActivatePaneDirection("Right") },
    { key = "w", mods = "CMD|SHIFT", action = act.ShowLauncherArgs({ flags = "WORKSPACES" }) },
    {
      key = "c",
      mods = "CMD|OPT",
      action = act.PromptInputLine({
        description = "Workspace name",
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            window:perform_action(act.SwitchToWorkspace({ name = line }), pane)
          end
        end),
      }),
    },
    {
      key = "r",
      mods = "CMD|OPT",
      action = act.PromptInputLine({
        description = "Rename workspace",
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
          end
        end),
      }),
    },
  },

  window_background_opacity = 0.9,
  macos_window_background_blur = 20,

  default_cursor_style = "BlinkingBlock",
  cursor_blink_rate = 500,
  scrollback_lines = 10000,
}
