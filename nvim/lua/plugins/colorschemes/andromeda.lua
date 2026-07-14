-- =============================================================================
-- Title: andromeda.lua
-- File: ~/repos/github.com/jihillestad/dotfiles/nvim/lua/plugins/andromeda.lua
-- About: Colorscheme
-- Credits:
-- Sources:
-- -https://github.com/idr4n/andromeda.nvim
-- =============================================================================;

return {
	"idr4n/andromeda.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		transparent = false, -- Disable background color
		terminal_colors = true, -- Configure terminal colors

		styles = {
			comments = { italic = true },
			keywords = { italic = true },
			functions = {},
			variables = {},
			floats = "normal", -- "dark" | "transparent" | "normal"
			sidebars = "normal", -- "dark" | "transparent" | "normal"
		},

		plugins = {
			all = true, -- Enable all plugin integrations
			-- Selectively disable plugins:
			-- telescope = false,
			-- neo_tree = false,
		},

		-- Override specific colors
		on_colors = function(colors)
			colors.cyan = "#00d5c6" -- Adjust cyan
		end,

		-- Override specific highlights
		on_highlights = function(highlights, colors)
			highlights.Comment = { fg = colors.fg_gutter, italic = true }
		end,
	},
}
