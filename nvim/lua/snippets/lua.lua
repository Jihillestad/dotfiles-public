-- =============================================================================
-- Title: lua.lua
-- File: ~/repos/github.com/jihillestad/dotfiles/nvim/lua/snippets/lua.lua
-- About: Lua specific snippets
-- Credits:
-- Sources:
-- =============================================================================

local h = require("luasnip-helpers")
local s, t, i, f, rep = h.s, h.t, h.i, h.f, h.rep

return {
	s({
		trig = "luatitle",
		name = "Insert a header to document the lua file",
		desc = "Insert a header to document the lua file",
	}, {
		t({ "-- =============================================================================", "-- Title: " }),
		f(h.get_filename, {}),
		t({ "", "-- File: " }),
		f(h.get_filepath_with_tilde, {}),
		t({ "", "-- About: " }),
		i(1),
		t({ "", "-- Credits: " }),
		i(2),
		t({ "", "-- Sources: " }),
		i(3),
		t({ "", "-- =============================================================================" }),
	}),
	s({
		trig = "luah2",
		name = "Insert a header to a Lua Code Section",
		desc = "Insert a header to a Lua Code Section",
	}, {
		t({ "-- =========================================================================", "-- Start " }),
		i(1),
		t({ " Section" }),
		t({ "", "-- =========================================================================", "", "" }),
		i(0),
		t({ "", "", "-- =========================================================================", "-- End " }),
		rep(1),
		t({ " Section" }),
		t({ "", "-- =========================================================================" }),
	}),
	s({
		trig = "path",
		name = "Insert file path comment",
		desc = "Insert full path of current buffer as a comment (with ~ for home)",
	}, {
		t("-- File: "),
		f(h.get_filepath_with_tilde, {}),
	}),
}
