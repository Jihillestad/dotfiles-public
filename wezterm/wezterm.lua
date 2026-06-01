-- =============================================================================
-- Title: wezterm.lua
-- File: ~/repos/github.com/jihillestad/dotfiles/wezterm/wezterm.lua
-- About: Main config file for wezterm terminal emulator
-- Credits: A special thanks to Lazar Nikolov for providing his dotfiles
-- Sources:
-- - https://github.com/nikolovlazar/dotfiles
-- =============================================================================

-- Connect to Wezterm API and other modules
local wezterm = require("wezterm")
-- local constants = require("constants")
local commands = require("commands")

-- This will hold the configuration
local config = wezterm.config_builder()

-- Font settings
-- config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 17
config.line_height = 1.2

-- Appearance
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.color_scheme = "tokyonight_night"
-- config.color_scheme = "Gruvbox Dark (Gogh)"
config.colors = {
	-- 	foreground = "#CBE0F0",
	-- 	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	-- 	selection_bg = "#033259",
	-- 	selection_fg = "#CBE0F0",
	-- 	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	-- 	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}
-- Make the most of your monitor's real estate by removing the padding around the terminal content
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
-- config.window_background_image = constants.bg_image
-- config.macos_window_background_blur = 40

-- Miscellaneous settings
config.max_fps = 120
config.prefer_egl = false
config.send_composed_key_when_left_alt_is_pressed = false

-- Custom commands
wezterm.on("augment-command-palette", function()
	return commands
end)

return config
