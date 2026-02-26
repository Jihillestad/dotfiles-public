-- =============================================================================
-- Title: treesitter.lua
-- File: ~/repos/github.com/jihillestad/dotfiles/nvim/lua/plugins/treesitter.lua
-- About: Make sure given parsers are installed for treesitter.
-- Credits:
-- Sources:
-- - https://github.com/nvim-treesitter/nvim-treesitter
-- =============================================================================

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"json",
				"vimdoc",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"prisma",
				"markdown",
				"markdown_inline",
				"svelte",
				"graphql",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"query",
				"hcl",
				"terraform",
				"python",
				"powershell",
			},
		},
	},
}
