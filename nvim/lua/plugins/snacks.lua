-- =============================================================================
-- Title: snacks.lua
-- File: ~/repos/github.com/jihillestad/dotfiles/nvim/lua/plugins/snacks.lua
-- About: Config ovverrides for the Snacks Features, whenever LazyVim defaults are in the way
-- Credits:
-- Sources:
-- - https://github.com/folke/snacks.nvim
-- =============================================================================

return {
	{
		"folke/snacks.nvim",
		opts = {
			words = { enabled = false }, -- I don't use this feature and it causes some issues with the "mini.surround" plugin, so I disable it
		},
	},
}
