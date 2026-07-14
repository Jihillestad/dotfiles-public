-- =============================================================================
-- Title: markdown.lua
-- File: ~/repos/github.com/jihillestad/dotfiles/nvim/lua/snippets/markdown.lua
-- About: Markdown specific snippets and helper functions
-- Credits: A special thanks to linkarzu for providing this in his dotfiles for
-- me to scavenge. I refactored to keep a clean language-specific config
-- https://github.com/linkarzu/dotfiles-latest/
-- =============================================================================

local h = require("luasnip-helpers")
local s, t, i, f = h.s, h.t, h.i, h.f

-- =========================================================================
-- Start Helper Function Section
-- =========================================================================

local function create_code_block_snippet(lang)
	return s({
		trig = lang,
		name = "Codeblock",
		desc = lang .. " codeblock",
	}, {
		t({ "```" .. lang, "" }),
		i(1),
		t({ "", "```" }),
	})
end

-- =========================================================================
-- End Helper Function Section
-- =========================================================================

-- =========================================================================
-- Start Code Block Markup Section
-- =========================================================================

local languages = {
	"hcl",
	"txt",
	"lua",
	"sql",
	"go",
	"regex",
	"bash",
	"markdown",
	"markdown_inline",
	"yaml",
	"json",
	"jsonc",
	"cpp",
	"csv",
	"java",
	"javascript",
	"python",
	"dockerfile",
	"html",
	"css",
	"templ",
	"php",
}

local snippets = {}
for _, lang in ipairs(languages) do
	table.insert(snippets, create_code_block_snippet(lang))
end

-- =========================================================================
-- End Code Block Markup Section
-- =========================================================================

-- =========================================================================
-- Start Linting and Formatting Ignore Section
-- =========================================================================

table.insert(
	snippets,
	s({
		trig = "chirpy",
		name = "Disable markdownlint and prettier for chirpy",
		desc = "Disable markdownlint and prettier for chirpy",
	}, {
		t({
			" ",
			"<!-- markdownlint-disable -->",
			"<!-- prettier-ignore-start -->",
			" ",
			"<!-- tip=green, info=blue, warning=yellow, danger=red -->",
			" ",
			"> ",
		}),
		i(1),
		t({ "", "{: .prompt-" }),
		i(2),
		t({ " }", " ", "<!-- prettier-ignore-end -->", "<!-- markdownlint-restore -->" }),
	})
)

table.insert(
	snippets,
	s({
		trig = "markdownlint",
		name = "Add markdownlint disable and restore headings",
		desc = "Add markdownlint disable and restore headings",
	}, {
		t({ " ", "<!-- markdownlint-disable -->", " ", "> " }),
		i(1),
		t({ " ", " ", "<!-- markdownlint-restore -->" }),
	})
)

table.insert(
	snippets,
	s({
		trig = "prettierignore",
		name = "Add prettier ignore start and end headings",
		desc = "Add prettier ignore start and end headings",
	}, {
		t({ " ", "<!-- prettier-ignore-start -->", " ", "> " }),
		i(1),
		t({ " ", " ", "<!-- prettier-ignore-end -->" }),
	})
)

-- =========================================================================
-- End Linting and Formatting Ignore Section
-- =========================================================================

-- =========================================================================
-- Start Link Section
-- =========================================================================

table.insert(
	snippets,
	s({
		trig = "linkc",
		name = "Paste clipboard as .md link",
		desc = "Paste clipboard as .md link",
	}, { t("["), i(1), t("]("), f(h.clipboard, {}), t(")") })
)

table.insert(
	snippets,
	s({
		trig = "linkt",
		name = 'Add this -> [](){:target="_blank"}',
		desc = 'Add this -> [](){:target="_blank"}',
	}, { t("["), i(1), t("]("), i(2), t('){:target="_blank"}') })
)

table.insert(
	snippets,
	s({
		trig = "blank",
		name = 'Add this {:target="_blank"}',
		desc = 'Add this {:target="_blank"}',
	}, { t('{:target="_blank"}') })
)

table.insert(
	snippets,
	s({
		trig = "linkex",
		name = "Paste clipboard as EXT .md link",
		desc = "Paste clipboard as EXT .md link",
	}, { t("["), i(1), t("]("), f(h.clipboard, {}), t('){:target="_blank"}') })
)

-- =========================================================================
-- End Link Section
-- =========================================================================

table.insert(
	snippets,
	s({
		trig = "todo",
		name = "Add TODO: item",
		desc = "Add TODO: item",
	}, { t("TODO: "), i(1) })
)

table.insert(
	snippets,
	s({
		trig = "dotfileslatest",
		name = "Adds -> [my dotfiles](https://github.com/linkarzu/dotfiles-latest)",
		desc = "Add link to https://github.com/linkarzu/dotfiles-latest",
	}, { t("[my dotfiles](https://github.com/linkarzu/dotfiles-latest)") })
)

table.insert(
	snippets,
	s({
		trig = "pagebreak",
		name = "Adds a blank line in markdown file",
		desc = "Adds a blank line in markdown file",
	}, { t('<div style="page-break-after: always; visibility: hidden"> pagebreak </div>') })
)

table.insert(
	snippets,
	s({
		trig = "bashex",
		name = "Basic bash script example",
		desc = "Simple bash script template",
	}, { t({ "```bash", "#!/bin/bash", "", "echo 'helix'", "echo 'deeznuts'", "```", "" }) })
)

table.insert(
	snippets,
	s({
		trig = "pythonex",
		name = "Basic Python script example",
		desc = "Simple Python script template",
	}, {
		t({
			"```python",
			"#!/usr/bin/env python3",
			"",
			"def main():",
			"    print('helix dizpython')",
			"",
			"if __name__ == '__main__':",
			"    main()",
			"```",
			"",
		}),
	})
)

return snippets
