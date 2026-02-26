-- =============================================================================
-- Title: copilot.lua
-- File: ~/repos/github.com/jihillestad/dotfiles/nvim/lua/plugins/ai/copilot.lua
-- About: Configuration for the Coiilot pluging for Neovim.
-- Credits:
-- Sources:
-- - https://github.com/zbirenbaum/copilot.lua
-- =============================================================================

return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		event = "InsertEnter",
		opts = {
			suggestion = { enabled = false }, -- disable inline suggestions
			panel = { enabled = false }, -- disable Copilot panel
			filetypes = {
				markdown = true,
				help = true,
			},
		},
	},
}
