-- =============================================================================
-- Title: luasnip.lua
-- File: ~/repos/github.com/jihillestad/dotfiles/nvim/lua/plugins/luasnip.lua
-- About: This file configures the LuaSnip plugin for snippet management in
-- Neovim
-- Credits: A special thanks to linkarzu for providing this in his dotfiles for
-- me to scavenge. This allows for more customization options.
-- https://github.com/linkarzu/dotfiles-latest/
-- =============================================================================

return {
	"L3MON4D3/LuaSnip",
	enabled = true,
	opts = function(_, opts)
		local ls = require("luasnip")

		-- Add prefix ";" to each one of my snippets using the extend_decorator
		-- I use this in combination with blink.cmp. This way I don't have to use
		-- the transform_items function in blink.cmp that removes the ";" at the
		-- beginning of each snippet. I added this because snippets that start with
		-- a symbol like ```bash aren't having their ";" removed
		-- https://github.com/L3MON4D3/LuaSnip/discussions/895
		-- NOTE: "THis extend_decorator works great, but I also tried to add the ";"
		-- prefix to all of the snippets loaded from friendly-snippets, but I was
		-- unable to do so, so I still have to use the transform_items in
		-- blink.cmp" - linkarzu
		local extend_decorator = require("luasnip.util.extend_decorator")
		-- Create trigger transformation function
		local function auto_semicolon(context)
			if type(context) == "string" then
				return { trig = ";" .. context }
			end
			return vim.tbl_extend("keep", { trig = ";" .. context.trig }, context)
		end
		-- Register and apply decorator properly
		extend_decorator.register(ls.s, {
			arg_indx = 1,
			extend = function(original)
				return auto_semicolon(original)
			end,
		})
		local s = extend_decorator.apply(ls.s, {})

		-- local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node
		local f = ls.function_node
		local extras = require("luasnip.extras")
		local rep = extras.rep

		-- =========================================================================
		-- Start Helper Function Section
		-- =========================================================================

		-- Helper function to get clipboard contents
		local function clipboard()
			return vim.fn.getreg("+")
		end

		-- Helper function to get the path of the current file you are working in
		local function get_filepath_with_tilde()
			local filepath = vim.api.nvim_buf_get_name(0)
			local home = os.getenv("HOME")
			-- Replace home directory path with ~
			if home and filepath:sub(1, #home) == home then
				filepath = "~" .. filepath:sub(#home + 1)
			end
			return filepath
		end

		-- Helper function to get the filename of the current file you are working in
		local function get_filename()
			local filepath = vim.api.nvim_buf_get_name(0)
			return vim.fn.fnamemodify(filepath, ":t")
		end

		-- =============================================================================
		-- End Helper Function Section
		-- =============================================================================

		-- Custom snippets
		-- the "all" after ls.add_snippets("all" is the filetype, you can know a
		-- file filetype with :set ft
		-- Custom snippets

		-- #####################################################################
		--                            Markdown
		-- #####################################################################

		-- Helper function to create code block snippets
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

		-- Define languages for code blocks
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

		-- Generate snippets for all languages
		local snippets = {}

		for _, lang in ipairs(languages) do
			table.insert(snippets, create_code_block_snippet(lang))
		end

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
				t({
					"",
					"{: .prompt-",
				}),
				-- In case you want to add a default value "tip" here, but I'm having
				-- issues with autosave
				-- i(2, "tip"),
				i(2),
				t({
					" }",
					" ",
					"<!-- prettier-ignore-end -->",
					"<!-- markdownlint-restore -->",
				}),
			})
		)

		table.insert(
			snippets,
			s({
				trig = "markdownlint",
				name = "Add markdownlint disable and restore headings",
				desc = "Add markdownlint disable and restore headings",
			}, {
				t({
					" ",
					"<!-- markdownlint-disable -->",
					" ",
					"> ",
				}),
				i(1),
				t({
					" ",
					" ",
					"<!-- markdownlint-restore -->",
				}),
			})
		)

		table.insert(
			snippets,
			s({
				trig = "prettierignore",
				name = "Add prettier ignore start and end headings",
				desc = "Add prettier ignore start and end headings",
			}, {
				t({
					" ",
					"<!-- prettier-ignore-start -->",
					" ",
					"> ",
				}),
				i(1),
				t({
					" ",
					" ",
					"<!-- prettier-ignore-end -->",
				}),
			})
		)

		table.insert(
			snippets,
			s({
				trig = "linkt",
				name = 'Add this -> [](){:target="_blank"}',
				desc = 'Add this -> [](){:target="_blank"}',
			}, {
				t("["),
				i(1),
				t("]("),
				i(2),
				t('){:target="_blank"}'),
			})
		)

		table.insert(
			snippets,
			s({
				trig = "blank",
				name = 'Add this {:target="_blank"}',
				desc = 'Add this {:target="_blank"}',
			}, {
				t('{:target="_blank"}'),
			})
		)

		table.insert(
			snippets,
			s({
				trig = "todo",
				name = "Add TODO: item",
				desc = "Add TODO: item",
			}, {
				t("TODO: "),
				i(1),
			})
		)

		-- Paste clipboard contents in link section, move cursor to ()
		table.insert(
			snippets,
			s({
				trig = "linkc",
				name = "Paste clipboard as .md link",
				desc = "Paste clipboard as .md link",
			}, {
				t("["),
				i(1),
				t("]("),
				f(clipboard, {}),
				t(")"),
			})
		)

		-- Paste clipboard contents in link section, move cursor to ()
		table.insert(
			snippets,
			s({
				trig = "linkex",
				name = "Paste clipboard as EXT .md link",
				desc = "Paste clipboard as EXT .md link",
			}, {
				t("["),
				i(1),
				t("]("),
				f(clipboard, {}),
				t('){:target="_blank"}'),
			})
		)

		-- Inserting "my dotfiles" link
		table.insert(
			snippets,
			s({
				trig = "dotfileslatest",
				name = "Adds -> [my dotfiles](https://github.com/linkarzu/dotfiles-latest)",
				desc = "Add link to https://github.com/linkarzu/dotfiles-latest",
			}, {
				t("[my dotfiles](https://github.com/linkarzu/dotfiles-latest)"),
			})
		)

		-- Inserting pagebreak
		table.insert(
			snippets,
			s({
				trig = "pagebreak",
				name = "Adds a blank line in markdown file",
				desc = "Adds a blank line in markdown file",
			}, {
				t('<div style="page-break-after: always; visibility: hidden"> pagebreak </div>'),
			})
		)

		-- Basic bash script template
		table.insert(
			snippets,
			s({
				trig = "bashex",
				name = "Basic bash script example",
				desc = "Simple bash script template",
			}, {
				t({
					"```bash",
					"#!/bin/bash",
					"",
					"echo 'helix'",
					"echo 'deeznuts'",
					"```",
					"",
				}),
			})
		)

		-- Basic Python script template
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

		ls.add_snippets("markdown", snippets)

		-- =========================================================================
		-- Start LaTeX Section
		-- =========================================================================

		-- Snippets for LaTexX files
		ls.add_snippets("tex", {
			-- moderncv
			s({
				trig = "projectexp",
				name = "[moderncv]Add a Project",
				desc = "[moderncv]Add a Project to your CV",
			}, {
				t({
					"\\cventry{",
				}),
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
				t({
					"",
					"{",
					" \\begin{itemize}",
					"   \\item{\\textbf{",
				}),
				i(6, "Responsibility"),
				t({ ":} " }),
				i(7, "Details"),
				t({ "}" }),
				t({
					"",
					" \\end{itemize}",
					"}",
				}),
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
			s({
				trig = "workexp",
				name = "[moderncv]Work Experience",
				desc = "[moderncv]Add Work Experience to your CV",
			}, {
				t({
					"\\cventry{",
				}),
				i(1, "Year"),
				t({ "}{" }),
				i(2, "Role"),
				t({ "}{" }),
				i(3, "Company"),
				t({ "}{" }),
				i(4, "City/Country"),
				t({ "}{}" }),
				t({
					"",
					"{",
				}),
				i(5, "Summary"),
				t({ "}" }),
			}),
			s({
				trig = "cvlang",
				name = "[moderncv]Language",
				desc = "[moderncv]Add a language to your CV",
			}, {
				t({ "\\cvcolumn{}{\\textbf{" }),
				i(1, "Language"),
				t({ ":} " }),
				i(2, "Proficiency"),
				t({ "}" }),
			}),
			s({
				trig = "cvref",
				name = "[moderncv]Reference",
				desc = "[moderncv]Add a reference to your CV",
			}, {
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
		})

		-- =========================================================================
		-- End LaTeX Section
		-- =========================================================================

		-- #####################################################################
		--                            Lua
		-- #####################################################################

		ls.add_snippets("lua", {
			s({
				trig = "luatitle",
				name = "Insert a header to document the lua file",
				desc = "Insert a header to document the lua file",
			}, {
				t({
					"-- =============================================================================",
					"-- Title: ",
				}),
				f(get_filename, {}),
				t({
					"",
					"-- File: ",
				}),
				f(get_filepath_with_tilde, {}),
				t({
					"",
					"-- About: ",
				}),
				i(1),
				t({
					"",
					"-- Credits: ",
				}),
				i(2),
				t({
					"",
					"-- Sources: ",
				}),
				i(3),
				t({
					"",
					"-- =============================================================================",
				}),
			}),
			s({
				trig = "luah2",
				name = "Insert a header to a Lua Code Section",
				desc = "Insert a header to a Lua Code Section",
			}, {
				t({
					"-- =========================================================================",
					"-- Start ",
				}),
				i(1),
				t({ " Section" }),
				t({
					"",
					"-- =========================================================================",
					"",
					"",
				}),
				i(0),
				t({
					"",
					"",
					"-- =========================================================================",
					"-- End ",
				}),
				rep(1),
				t({ " Section" }),
				t({
					"",
					"-- =========================================================================",
				}),
			}),
			s({
				trig = "path",
				name = "Insert file path comment",
				desc = "Insert full path of current buffer as a comment (with ~ for home)",
			}, {
				t("-- File: "),
				f(get_filepath_with_tilde, {}),
			}),
		})

		-- #####################################################################
		--                         all the filetypes
		-- #####################################################################
		ls.add_snippets("all", {
			s({
				trig = "credits",
				name = "Add this -> A special thanks to $name for providing his dotfiles",
				desc = "Add this -> A special thanks to $name for providing his dotfiles",
			}, {
				t("A special thanks to "),
				i(1),
				t(" for providing this in his dotfiles"),
			}),
		})
		return opts
	end,
}
