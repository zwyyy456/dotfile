-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Mocha"
config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
-- config.font = wezterm.font_with_fallback({
-- "Monaco Nerd Font Mono",
-- "Moncao",
-- "PingFang SC",
-- })
config.font = wezterm.font_with_fallback({
	{ family = "Monaco Nerd Font Mono", harfbuzz_features = { "liga=0" } },
	"PingFang SC",
})
config.font_size = 13.0

-- and finally, return the configuration to wezterm
return config
