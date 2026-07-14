-- =============================================================================
-- Title: tex.lua
-- File: ~/repos/github.com/jihillestad/dotfiles/nvim/lua/snippets/tex.lua
-- About: LaTeSX specific snippets
-- Credits:
-- Sources:
-- =============================================================================

local h = require("luasnip-helpers")
local s, t, i = h.s, h.t, h.i

return {

	-- =========================================================================
	-- Start ModernCV Section
	-- =========================================================================

	s({ trig = "projectexp", name = "[moderncv]Add a Project", desc = "[moderncv]Add a Project to your CV" }, {
		t({ "\\cventry{" }),
		i(1, "Year"),
		t({ "}{" }),
		i(2, "Role"),
		t({ "}{" }),
		i(3, "PName"),
		t({ "}{" }),
		i(4, "Company"),
		t({ "}{" }),
		i(5, "City/Country"),
		t({ "}" }),
		t({ "", "{", " \\begin{itemize}", "   \\item{\\textbf{" }),
		i(6, "Responsibility"),
		t({ ":} " }),
		i(7, "Details"),
		t({ "}" }),
		t({ "", " \\end{itemize}", "}" }),
	}),
	s({
		trig = "projitem",
		name = "[moderncv]Project Item",
		desc = "[moderncv]Add a bullet point to add more responsibilities to the project",
	}, {
		t({ "\\item{\\textbf{" }),
		i(1, "Responsibility"),
		t({ ":} " }),
		i(2, "Details"),
		t({ "}" }),
	}),
	s({ trig = "workexp", name = "[moderncv]Work Experience", desc = "[moderncv]Add Work Experience to your CV" }, {
		t({ "\\cventry{" }),
		i(1, "Year"),
		t({ "}{" }),
		i(2, "Role"),
		t({ "}{" }),
		i(3, "Company"),
		t({ "}{" }),
		i(4, "City/Country"),
		t({ "}{}" }),
		t({ "", "{" }),
		i(5, "Summary"),
		t({ "}" }),
	}),
	s({ trig = "cvlang", name = "[moderncv]Language", desc = "[moderncv]Add a language to your CV" }, {
		t({ "\\cvcolumn{}{\\textbf{" }),
		i(1, "Language"),
		t({ ":} " }),
		i(2, "Proficiency"),
		t({ "}" }),
	}),
	s({ trig = "cvref", name = "[moderncv]Reference", desc = "[moderncv]Add a reference to your CV" }, {
		t({ "\\item{" }),
		i(1, "name"),
		t({ ", " }),
		i(2, "position"),
		t({ ", " }),
		i(3, "phone number"),
		t({ ", " }),
		i(4, "email address"),
		t({ "}" }),
	}),

	-- =========================================================================
	-- End ModernCV Section
	-- =========================================================================
}
