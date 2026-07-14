-- =============================================================================
-- Title: luasnip-helpers.lua
-- File: ~/repos/github.com/jihillestad/dotfiles/nvim/lua/luasnip-helpers.lua
-- About: Exports Helper Functions and Conciseness Variables
-- Credits:
-- Sources:
-- =============================================================================

-- =========================================================================
-- Start Conciseness Section
-- =========================================================================

local M = {}
local ls = require("luasnip")
local extend_decorator = require("luasnip.util.extend_decorator")

-- Registered once, when this module is first required (require() caches
-- modules, so this block only ever runs a single time regardless of how
-- many snippet files pull it in).
local function auto_semicolon(context)
	if type(context) == "string" then
		return { trig = ";" .. context }
	end
	return vim.tbl_extend("keep", { trig = ";" .. context.trig }, context)
end

extend_decorator.register(ls.s, {
	arg_indx = 1,
	extend = function(original)
		return auto_semicolon(original)
	end,
})

-- Decorated snippet constructor -- every snippet built with M.s gets the
-- ";" prefix automatically, exactly like in your original file.
M.s = extend_decorator.apply(ls.s, {})

-- Common node aliases, so snippet files don't each re-require luasnip
M.t = ls.text_node
M.i = ls.insert_node
M.f = ls.function_node
M.c = ls.choice_node
M.rep = require("luasnip.extras").rep
M.fmt = require("luasnip.extras.fmt").fmt
M.fmta = require("luasnip.extras.fmt").fmta

-- =========================================================================
-- End Conciseness Section
-- =========================================================================

-- =========================================================================
-- Start Snippets Global Helper Functions Section
-- =========================================================================

function M.clipboard()
	return vim.fn.getreg("+")
end

function M.get_filepath_with_tilde()
	local filepath = vim.api.nvim_buf_get_name(0)
	local home = os.getenv("HOME")
	if home and filepath:sub(1, #home) == home then
		filepath = "~" .. filepath:sub(#home + 1)
	end
	return filepath
end

function M.get_filename()
	local filepath = vim.api.nvim_buf_get_name(0)
	return vim.fn.fnamemodify(filepath, ":t")
end

-- =========================================================================
-- End Snippets Global Helper Functions Section
-- =========================================================================

return M
