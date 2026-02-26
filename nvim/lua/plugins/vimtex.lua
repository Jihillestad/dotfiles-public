-- =============================================================================
-- Title: vimtex.lua
-- File: ~/repos/github.com/jihillestad/dotfiles/nvim/lua/plugins/vimtex.lua
-- About: This file configures the VimTeX plugin for LaTeX support in NeoVim. It
-- sets up Skim as the PDF viewer with synchronization, and ensures that VimTeX
-- cleans up temporary files when quitting. This configuration enhances the
-- LaTeX editing experience by providing seamless PDF viewing and efficient file
-- management.
-- Credits:
-- Sources:
-- - https:/github.com/lervag/vimtex
-- =============================================================================

return {
	"lervag/vimtex",
	init = function()
		vim.g.vimtex_view_method = "skim"
		vim.g.vimtex_skim_sync = 1
		vim.g.vimtex_skim_activate = 1
		vim.g.vimtex_format_enabled = 1

		local au_group = vim.api.nvim_create_augroup("vimtex_events", {})

		vim.api.nvim_create_autocmd("User", {
			pattern = "VimtexEventQuit",
			group = au_group,
			command = "VimtexClean",
		})
	end,
}
