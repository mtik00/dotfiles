local wezterm = require 'wezterm'
local module = {}

function module.apply_to_config(config)
    -- https://wezfurlong.org/wezterm/colorschemes/index.html
    -- config.color_scheme = 'Darkside (Gogh)'
    config.color_scheme = 'Tomorrow (dark) (terminal.sexy)'

    -- This is my chosen font, we will get into installing fonts on windows later
    config.font = wezterm.font('FiraCode Nerd Font')
    config.font_size = 11
    config.launch_menu = launch_menu

    -- makes my cursor blink 
    config.default_cursor_style = 'BlinkingBar'

    config.foreground_text_hsb = {
        hue = 1.0,
        saturation = 1.0,
        brightness = 0.8,
    }

    -- config.window_background_image = wezterm.executable_dir .. '/../terminal-backgrounds/AdamsYosemite.jpg'

    -- 2. Dim the image (adjust the brightness below 1.0)
    config.window_background_image_hsb = {
        brightness = 0.05, -- Lower this number to make it darker (e.g., 0.1 to 0.5)
        hue = 1.0,         -- Keep colors as they are
        saturation = 0.0,  -- Slightly desaturate if colors are too vibrant
    }
end

return module
