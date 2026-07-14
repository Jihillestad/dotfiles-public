-- ==================================================================================================
-- Title: vim-maximizer Configuration
-- About: This file configures the vim-maximizer plugin for maximizing and minimizing splits in
-- Neovim.
-- ==================================================================================================

return {
	"szw/vim-maximizer",
	keys = {
		{ "<c-w>m", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
	},
}
