-- =============================================================================
-- Title: init.lua
-- File: ~/repos/github.com/jihillestad/dotfiles/wezterm/commands/init.lua
-- About: This fiule is used for wezterm to know where to find custom commands.
-- Credits: A special thanks to Lazar Nikolov for providing this in his dotfiles
-- Sources:
-- - https://github.com/nikolovlazar/dotfiles
-- =============================================================================
local toggle_transparency = require("commands.toggle-transparency")

local M = {
	toggle_transparency,
}

return M
