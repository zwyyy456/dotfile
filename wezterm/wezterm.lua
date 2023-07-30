-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Mariana"
config.font_size = 13.0
if wezterm.target_triple == "aarch64-apple-darwin" then
	-- This is where you actually apply your config choices

	-- For example, changing the color scheme:
	config.default_prog = { "fish" }
	-- config.font = wezterm.font_with_fallback({
	-- "Monaco Nerd Font Mono",
	-- "Moncao",
	-- "PingFang SC",
	-- })
	config.font = wezterm.font_with_fallback({
		{ family = "Monaco Nerd Font Mono", harfbuzz_features = { "liga=0" } },
		"PingFang SC",
	})

	-- and finally, return the configuration to wezterm
elseif wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "pwsh" }
	config.font = wezterm.font_with_fallback({
		{ family = "FuraMono NFM", harfbuzz_features = { "liga=0" } },
		"Microsoft Yahei",
	})
end
return config
