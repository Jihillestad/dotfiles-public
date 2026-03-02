-- =============================================================================
-- Title: snacks.lua
-- File: ~/repos/github.com/jihillestad/dotfiles/nvim/lua/plugins/snacks.lua
-- About: Config ovverrides for the Snacks Features, whenever LazyVim defaults are in the way
-- Credits: A special thanks to linkarzu for providing useful configs in his
-- dotfiles
-- Sources:
-- - https://github.com/folke/snacks.nvim
-- =============================================================================

return {
	{
		"folke/snacks.nvim",
		keys = {
			-- I use this keymap with mini.files, but snacks explorer was taking over
			-- https://github.com/folke/snacks.nvim/discussions/949
			{ "<leader>e", false },
			{
				"<leader>sg",
				function()
					Snacks.picker.grep({
						-- Exclude results from grep picker
						-- I think these have to be specified in gitignore syntax
						exclude = { "dictionaries/words.txt" },
					})
				end,
				desc = "Grep",
			},
			-- Open git log in vertical view
			{
				"<leader>gl",
				function()
					Snacks.picker.git_log({
						finder = "git_log",
						format = "git_log",
						preview = "git_show",
						confirm = "git_checkout",
						layout = "vertical",
					})
				end,
				desc = "Git Log",
			},
			-- Navigate my buffers
			{
				"<S-h>",
				function()
					Snacks.picker.buffers({
						-- I always want my buffers picker to start in normal mode
						on_show = function()
							vim.cmd.stopinsert()
						end,
						finder = "buffers",
						format = "buffer",
						hidden = false,
						unloaded = true,
						current = true,
						sort_lastused = true,
						win = {
							input = {
								keys = {
									["d"] = "bufdelete",
								},
							},
							list = { keys = { ["d"] = "bufdelete" } },
						},
						-- In case you want to override the layout for this keymap
						-- layout = "ivy",
					})
				end,
				desc = "[P]Snacks picker buffers",
			},
		},
		opts = {
			words = { enabled = false }, -- I don't use this feature and it causes some issues with the "mini.surround" plugin, so I disable it
			picker = {
				-- My ~/github/dotfiles-latest/neovim/lazyvim/lua/config/keymaps.lua
				-- file was always showing at the top, I needed a way to decrease its
				-- score, in frecency you could use :FrecencyDelete to delete a file
				-- from the database, here you can decrease it's score
				transform = function(item)
					if not item.file then
						return item
					end
					-- Demote the "lazyvim" keymaps file:
					if item.file:match("lazyvim/lua/config/keymaps%.lua") then
						item.score_add = (item.score_add or 0) - 30
					end
					return item
				end,
				-- In case you want to make sure that the score manipulation above works
				-- or if you want to check the score of each file
				debug = {
					scores = false, -- show scores in the list
				},
				-- I like the "ivy" layout, so I set it as the default globaly, you can
				-- still override it in different keymaps
				layout = {
					preset = "ivy",
					-- When reaching the bottom of the results in the picker, I don't want
					-- it to cycle and go back to the top
					cycle = false,
				},
				layouts = {
					-- I wanted to modify the ivy layout height and preview pane width,
					-- this is the only way I was able to do it
					-- NOTE: I don't think this is the right way as I'm declaring all the
					-- other values below, if you know a better way, let me know
					--
					-- Then call this layout in the keymaps above
					-- got example from here
					-- https://github.com/folke/snacks.nvim/discussions/468
					ivy = {
						layout = {
							box = "vertical",
							backdrop = false,
							row = -1,
							width = 0,
							height = 0.5,
							border = "top",
							title = " {title} {live} {flags}",
							title_pos = "left",
							{ win = "input", height = 1, border = "bottom" },
							{
								box = "horizontal",
								{ win = "list", border = "none" },
								{ win = "preview", title = "{preview}", width = 0.5, border = "left" },
							},
						},
					},
					-- I wanted to modify the layout width
					--
					vertical = {
						layout = {
							backdrop = false,
							width = 0.8,
							min_width = 80,
							height = 0.8,
							min_height = 30,
							box = "vertical",
							border = "rounded",
							title = "{title} {live} {flags}",
							title_pos = "center",
							{ win = "input", height = 1, border = "bottom" },
							{ win = "list", border = "none" },
							{ win = "preview", title = "{preview}", height = 0.4, border = "top" },
						},
					},
				},
				matcher = {
					frecency = true,
				},
				win = {
					input = {
						keys = {
							-- to close the picker on ESC instead of going to normal mode,
							-- add the following keymap to your config
							["<Esc>"] = { "close", mode = { "n", "i" } },
							-- I'm used to scrolling like this in LazyGit
							["J"] = { "preview_scroll_down", mode = { "i", "n" } },
							["K"] = { "preview_scroll_up", mode = { "i", "n" } },
							["H"] = { "preview_scroll_left", mode = { "i", "n" } },
							["L"] = { "preview_scroll_right", mode = { "i", "n" } },
						},
					},
				},
				formatters = {
					file = {
						filename_first = true, -- display filename before the file path
						truncate = 80,
					},
				},
			},
		},
	},
}
