local wezterm = require 'wezterm'

local base = require 'base'
local mouse = require 'mouse'
local theme = require 'theme'
local tmux = require 'tmux'

local config = wezterm.config_builder()

base.apply_to_config(config)
mouse.apply_to_config(config)
theme.apply_to_config(config)
tmux.apply_to_config(config)

return config
