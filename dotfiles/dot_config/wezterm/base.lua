-- These are the basic's for using wezterm.
-- Mux is the mutliplexes for windows etc inside of the terminal
-- Action is to perform actions on the terminal
local wezterm = require 'wezterm'

local mux = wezterm.mux
local act = wezterm.action

local module = {}

local extra_keys = {
    { key = 'Insert', mods = 'SHIFT', action = act.PasteFrom 'Clipboard' },
    { key = 'V', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
    { key = 'C', mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection' },
    -- { key = 'F', mods = 'CTRL|SHIFT', action = act.Search={CaseSensitiveString=""} },
}

local search_mode_keys = {
    { key = 'Enter', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
    { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },
    { key = 'n', mods = 'CTRL', action = act.CopyMode 'NextMatch' },
    { key = 'p', mods = 'CTRL', action = act.CopyMode 'PriorMatch' },
    { key = 'r', mods = 'CTRL', action = act.CopyMode 'CycleMatchType' },
    { key = 'u', mods = 'CTRL', action = act.CopyMode 'ClearPattern' },
    {
        key = 'PageUp',
        mods = 'NONE',
        action = act.CopyMode 'PriorMatchPage',
    },
    {
        key = 'PageDown',
        mods = 'NONE',
        action = act.CopyMode 'NextMatchPage',
    },
    { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'PriorMatch' },
    { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'NextMatch' },
}

function module.apply_to_config(config)
    config.default_domain = 'WSL:Ubuntu-24.04'
    config.wsl_domains = {
        {
            name = 'WSL:Ubuntu-24.04',
            distribution = 'Ubuntu-24.04',
            default_cwd = '~',
        },
    }
    config.enable_scroll_bar = true
    config.initial_cols = 120
    config.initial_rows = 35
    config.hyperlink_rules = wezterm.default_hyperlink_rules()

    config.keys = config.keys or {}

    for _, v in ipairs(extra_keys) do
        table.insert(config.keys, v)
    end

    config.window_close_confirmation = 'NeverPrompt'

    config.audible_bell = "Disabled"
end

return module
