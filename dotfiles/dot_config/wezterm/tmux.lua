-- This configuration makes wezterm act like tmux with defaults.
local wezterm = require 'wezterm'
local module = {}

local extra_keys = {
    -- Toggle current pane zoom (tmux: prefix + z)
    { key = 'z', mods = 'LEADER', action = wezterm.action.TogglePaneZoomState },

    -- Create a new tab (tmux: prefix + c)
    { key = 'c', mods = 'LEADER', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },

    -- Go to the next tab (tmux: prefix + n)
    { key = 'n', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(1) },

    -- Go to the previous tab (tmux: prefix + p)
    { key = 'p', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(-1) },

    -- Split horizontally (tmux: prefix + %)
    { key = '%', mods = 'LEADER|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain', cwd = "~" } },

    -- Split vertically (tmux: prefix + ")
    { key = '"', mods = 'LEADER|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain', cwd = "~" } },

    -- Move between panes using vim directions (prefix + arrow)
    { key = 'LeftArrow', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Left' },
    { key = 'DownArrow', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Down' },
    { key = 'UpArrow', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Up' },
    { key = 'RightArrow', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Right' },
}

function module.apply_to_config(config)

    -- TMUX-like config
    config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

    config.keys = config.keys or {}

    for _, v in ipairs(extra_keys) do
        table.insert(config.keys, v)
    end
end

wezterm.on('update-right-status', function(window, pane)
  local status = ""
  
  -- Get info for all panes within the active tab
  local tab = pane:tab()
  if tab then
    for _, pane_info in ipairs(tab:panes_with_info()) do
      -- Check if the pane is both the active one and currently zoomed
      if pane_info.is_active and pane_info.is_zoomed then
        status = " [ZOOMED] "
        break
      end
    end
  end
  
  -- Apply the text to the right status area
  window:set_right_status(wezterm.format({
    { Foreground = { Color = '#ff5555' } }, 
    { Attribute = { Intensity = 'Bold' } },
    { Text = status },
  }))
end)

return module
