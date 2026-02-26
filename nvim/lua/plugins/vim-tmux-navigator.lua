-- =============================================================================
-- Title: vim-tmux-navigator.lua
-- File: ~/repos/github.com/jihillestad/dotfiles/nvim/lua/plugins/vim-tmux-navigator.lua
-- About: Allows navigating between Neovim and TMUX panes using some keybinfings
-- Credits:
-- Sources:
-- - http://www.github.com/christoomey/vim-tmux-navigator
-- =============================================================================

return {
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
}
