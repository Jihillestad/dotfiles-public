-- =============================================================================
-- Title: mini-pairs.lua
-- File: ~/repos/github.com/jihillestad/dotfiles/nvim/lua/plugins/mini-pairs.lua
-- About: Adding some useful options on top of LazyVim's default config for
-- mini-pairs. Sometimes auto oairs are counter-productive, which these
-- settings improve.
-- Credits: A special thanks to linkarzu for providing thi in his dotfiles.
-- Sources:
-- - http:/github.com/nvim-mini/mini.pairs
-- =============================================================================

return {
	"nvim-mini/mini.pairs",
	event = "VeryLazy",
	opts = {
		modes = { insert = true, command = true, terminal = false },
		-- skip autopair when next character is one of these
		skip_next = [=[[%w%%%'%[%"%.%`%$]]=], -- Disable closing pairs if the next character is a word character, a percent sign, a single quote, an opening square bracket, a double quote, a dot, a backtick, or a dollar sign
		-- skip autopair when the cursor is inside these treesitter nodes
		skip_ts = { "string" },
		-- skip autopair when next character is closing pair
		-- and there are more closing pairs than opening pairs
		skip_unbalanced = true,
		-- better deal with markdown code blocks
		markdown = true,
		mappings = {
			["`"] = false,
		},
	},
	config = function(_, opts)
		LazyVim.mini.pairs(opts)
	end,
}
