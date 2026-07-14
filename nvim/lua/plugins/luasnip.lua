-- =============================================================================
-- Title: luasnip.lua
-- File: ~/repos/github.com/jihillestad/dotfiles/nvim/lua/plugins/luasnip.lua
-- About: This file configures the LuaSnip plugin for snippet management in
-- Neovim
-- =============================================================================
--
return {
	"L3MON4D3/LuaSnip",
	enabled = true,
	opts = function(_, opts)
		require("luasnip.loaders.from_lua").lazy_load({
			paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
		})
		return opts
	end,
}
