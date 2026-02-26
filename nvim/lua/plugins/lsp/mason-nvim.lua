-- =============================================================================
-- Title: mason-nvim.lua
-- File: ~/repos/github.com/jihillestad/dotfiles/nvim/lua/plugins/lsp/mason-nvim.lua
-- About: This config is used to define a list of tools for Mason to install
-- Credits:
-- Sources:
-- - http://www.github.com/mason-org/mason.nvim
-- =============================================================================

return {
	"mason-org/mason.nvim",
	opts = function(_, opts)
		vim.list_extend(opts.ensure_installed, {
			"html-lsp",
			"harper-ls",
			"emmet-ls",
			"prettier",
			"isort",
			"black",

			-- Not installing the tree-sitter CLI through mason due do this
			-- https://github.com/LazyVim/LazyVim/issues/6437#issuecomment-3304278107
			-- "tree-sitter-cli",

			"markdown-oxide",
		})
	end,
}
