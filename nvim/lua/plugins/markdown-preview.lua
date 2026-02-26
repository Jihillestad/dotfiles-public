-- =============================================================================
-- Title: markdown-preview
-- File: ~/repos/github.com/jihillestad/dotfiles/nvim/lua/plugins/markdown-preview.lua
-- About: This plugin creates a pdf preview of the markdown file
-- Credits: A special thanks to linkarzu for providing this in his dotfiles
-- Sources:
--  https://github.com/iamcco/markdown-preview.nvim
-- =============================================================================

return {
	"iamcco/markdown-preview.nvim",
	keys = {
		{
			"<leader>mp",
			ft = "markdown",
			"<cmd>MarkdownPreviewToggle<cr>",
			desc = "Markdown Preview",
		},
	},
	init = function()
		-- The default filename is 「${name}」and I just hate those symbols
		vim.g.mkdp_page_title = "${name}"
	end,
}
