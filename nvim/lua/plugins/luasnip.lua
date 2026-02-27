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

		table.insert(
			snippets,
			s({
				trig = "vid",
				name = "Add Vid-Id tag",
				desc = "Add Vid-Id tag",
			}, {
				t("Vid-Id"),
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

		-- Inserting "my dotfiles" link
		table.insert(
			snippets,
			s({
				trig = "newline",
				name = "Adds a blank line in markdown file",
				desc = "Adds a blank line in markdown file",
			}, {
				t('<div style="page-break-after: always; visibility: hidden"> pagebreak </div>'),
			})
		)

		-- Inserting "my dotfiles" link
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

		table.insert(
			snippets,
			s({
				trig = "supportme",
				name = "Inserts links (Ko-fi, Twitter, TikTok)",
				desc = "Inserts links (Ko-fi, Twitter, TikTok)",
			}, {
				t({
					"Join discord for free -> https://discord.gg/NgqMgwwtMH",
					"If you want to support me by becoming a YouTube member",
					"https://www.youtube.com/channel/UCrSIvbFncPSlK6AdwE2QboA/join",
					"☕ Support me -> https://ko-fi.com/linkarzu",
					"☑ My Twitter -> https://x.com/link_arzu",
					"❤‍🔥 My tiktok -> https://www.tiktok.com/@linkarzu",
					"My dotfiles (remember to star them) -> https://github.com/linkarzu/dotfiles-latest",
					"A link to my resume -> https://resume.linkarzu.com/",
				}),
			})
		)

		table.insert(
			snippets,
			s({
				trig = "discord",
				name = "discord support",
				desc = "discord support",
			}, {
				t({
					"```txt",
					"I have a members only discord, it's goal is to troubleshoot stuff related to my videos, and try to help users out",
					"If you want to join, the link can be found below",
					"https://www.youtube.com/channel/UCrSIvbFncPSlK6AdwE2QboA/join",
					"```",
				}),
			})
		)

		-- Add a snippet for inserting a blogpost article template
		table.insert(
			snippets,
			s({
				trig = "blogposttemplate",
				name = "Insert blog post template",
				desc = "Insert blog post template with frontmatter and sections",
			}, {
				t({ "---", "title: " }),
				i(1, ""),
				t({ "", "description: " }),
				i(2, ""),
				t({
					"",
					"image:",
					"  path: ./../../assets/img/imgs/250117-thux-simple-bar-sketchybar.avif",
					"date: '2026-",
				}),
				i(3, ""),
				t({ " 06:10:00 +0000'" }),
				t({
					"",
					"categories:",
					"  - ",
				}),
				i(4, ""),
				t({
					"",
					"tags:",
					"  - ",
				}),
				i(5, ""),
				t({
					"",
					"  - tutorial",
					"  - youtube",
					"  - video",
					"---",
					"## Contents",
					"",
					"### Table of contents",
					"",
					"<!-- toc -->",
					"",
					"<!-- tocstop -->",
					"",
					"## YouTube video",
					"",
					"{% include embed/youtube.html id='' %}",
					"Paste thumbnail here",
				}),
				i(6, ""),
				t({
					"",
					"",
					"## Pre-requisites",
					"",
					"- List any here",
					"",
					"## Community-driven promotion",
					"",
					"Do you want to promote yourself in my channel? I'm not talking about a company",
					"like notion, brilliant, and all those other ones we're using to seeing. I'm",
					"talking about you as a person, do you have a project, course, youtube channel or",
					"product and trying to reach an audience?",
					"",
					'If interested, pricing and all the details can be found [in this other page](https://chirpy.home.linkarzu.com/about/#community-driven-promotion){:target="_blank"}',
					"",
					"## You're a fraud, why do you ask for money, isn't YouTube Ads enough?",
					"",
					'- I explain all of this in the "about me page" link below:',
					'  - [youre-a-fraud-why-do-you-ask-for-money-isnt-youtube-ads-enough](https://linkarzu.com/about/#youre-a-fraud-why-do-you-ask-for-money-isnt-youtube-ads-enough){:target="_blank"}',
					"  - Above you'll also find links to my discord, social media, etc",
					"",
				}),
			})
		)

		-- Add a snippet for inserting a video markdown template
		table.insert(
			snippets,
			s({
				trig = "videotemplate",
				name = "Insert video markdown template",
				desc = "Insert video markdown template",
			}, {
				t("## "),
				i(1, "cursor"),
				t(" video"),
				t({ "", "", "All of the details and the demo are covered in the video:", "" }),
				t({ "", "If you don't like watching videos, the keymaps are in " }),
				t("[my dotfiles](https://github.com/linkarzu/dotfiles-latest)"),
				t({
					"",
					"",
					"```txt",
					"Members only discord",
					"https://www.youtube.com/channel/UCrSIvbFncPSlK6AdwE2QboA/join",
					"",
					"If you find this video helpful and want to support me",
					"https://ko-fi.com/linkarzu",
					"",
					"Follow me on twitter",
					"https://x.com/link_arzu",
					"",
					"My dotfiles (remember to star them)",
					"https://github.com/linkarzu/dotfiles-latest",
					"",
					"Videos mentioned in this video:",
					"",
					"#linkarzu",
					"",
					"1:00 - VIDEO video 1",
					"2:00 - VIDEO video 2",
					"```",
					"",
					"Video timeline:",
					"",
					"```txt",
					"0:00 -",
					"```",
					"",
					"```txt",
					"Join discord for free -> https://discord.gg/NgqMgwwtMH",
					"If you want to support me by becoming a YouTube member",
					"https://www.youtube.com/channel/UCrSIvbFncPSlK6AdwE2QboA/join",
					"☕ Support me -> https://ko-fi.com/linkarzu",
					"☑ My Twitter -> https://x.com/link_arzu",
					"❤‍🔥 My tiktok -> https://www.tiktok.com/@linkarzu",
					"Start your setap free trial (my affiliate link)",
					"setapp.sjv.io/QjKK1a",
					"Start your 1password trial  (my affiliate link)",
					"https://www.dpbolvw.net/click-101327218-15917064",
					"My dotfiles (remember to star them) -> https://github.com/linkarzu/dotfiles-latest",
					"A link to my resume -> https://resume.linkarzu.com/",
					"```",
					"",
				}),
			})
		)

		table.insert(
			snippets,
			s({
				trig = "video-skitty",
				name = "New video in skitty-notes",
				desc = "New video in skitty-notes",
			}, {
				t("## "),
				i(1, "video name"),
				t({
					"",
					"",
					"- [ ] ",
				}),
				i(2, ""), -- This is now the second jump point
				t({
					"",
					"- [ ] **Thank supporters**",
					"- [ ] Push GitHub changes",
					"- [ ] Share discord server",
					"",
				}),
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

		-- -- Make Typst inherit Markdown snippets
		-- ls.filetype_extend("typst", { "markdown" })

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
