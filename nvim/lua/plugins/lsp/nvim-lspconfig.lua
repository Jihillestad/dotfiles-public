-- =============================================================================
-- Title: nvim-lspconfig.lua
-- File: ~/repos/github.com/jihillestad/dotfiles/nvim/lua/plugins/lsp/nvim-lspconfig.lua
-- About: Configuring LSP Servers,
-- Credits: A special thanks to linkarzu for providing this in his dotfiles
-- Sources:
-- - http://www.github.com/neovim/nvim-lspconfig
-- =============================================================================

return {
	"neovim/nvim-lspconfig",
	opts = {
		-- This disables inlay hints
		-- When programming in Go, these made my experience feel like shit, because were
		-- very intrusive and I never got used to them.
		--
		-- Folke has a keymap to toggle inaly hints with <leader>uh
		inlay_hints = { enabled = false },

		-- Add a border to the diagnostics window or popup
		-- https://github.com/LazyVim/LazyVim/discussions/2825#discussioncomment-8914135
		diagnostics = {
			float = {
				border = "rounded",
			},
		},

		servers = {
			["*"] = {
				keys = {
					{ "<leader>rs", ":lsp restart<CR>", desc = "Restart LSP" },
				},
			},
			marksman = {
				enabled = false,
			},
			markdown_oxide = {
				filetypes = { "markdown", "mdx" },
				-- Ensure that dynamicRegistration is enabled
				-- This allows the LS to take into account actions like Create Unresolved File, etc
				capabilities = vim.tbl_deep_extend(
					"force",
					vim.lsp.protocol.make_client_capabilities(),
					require("blink.cmp").get_lsp_capabilities(),
					{
						workspace = {
							didChangeWatchedFiles = {
								dynamicRegistration = true,
							},
						},
					}
				),
			},
			-- https://www.reddit.com/r/neovim/comments/1j7ookn/comment/mgysste/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
			-- The hover window configuration for the diagnostics is done in lamw26wmal
			-- ~/github/dotfiles-latest/neovim/neobean/lua/config/autocmds.lua
			harper_ls = {
				enabled = true,
				filetypes = { "markdown", "typst" },
				settings = {
					["harper-ls"] = {
						userDictPath = "~/repos/github.com/jihillestad/dotfiles/nvim/spell/en.utf-8.add",
						-- linters = {
						--   -- Disabling ToDoHyphen because of
						--   -- https://github.com/Automattic/harper/issues/1573#issuecomment-3777776431
						--   -- -- ToDoHyphen = false,
						--   -- SentenceCapitalization = true,
						--   -- SpellCheck = true,
						-- },
						isolateEnglish = true,
						markdown = {
							-- [ignores this part]()
							-- [[ also ignores my marksman links ]]
							IgnoreLinkTitle = true,
						},
					},
				},
			},
			emmet_language_server = {
				filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
			},
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						completion = { callSnippet = "Replace" },
						workspace = { checkThirdParty = false },
					},
				},
			},
			copilot = {
				enabled = false,
			},
		},
	},
}
