-- =============================================================================
-- Title: kanagawa.lua
-- File: ~/repos/github.com/jihillestad/dotfiles/nvim/lua/plugins/kanagawa.lua
-- About: Colorscheme
-- Credits:
-- Sources:
-- - https://github.com/rebelot/kanagawa.nvim
-- =============================================================================

return {
	"rebelot/kanagawa.nvim",
	-- priority = 1000,
	opts = {
		colors = {
			theme = {
				all = {
					ui = {
						bg_gutter = "none",
					},
				},
			},
		},
		-- transparent = false,
		-- theme = "wave",
	},
}
