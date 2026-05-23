-- =============================================================================
-- Title: conform.lua
-- File: ~/repos/github.com/jihillestad/dotfiles/nvim/lua/plugins/conform.lua
-- About: This file configures the conform.nvim plugin for code formatting in
-- Neovim
-- Credits: linkarzu for providing this in his dotfiles for me to scavenge.
-- Sources:
-- - https://github.com/stevearc/conform.nvim
-- - https://github.xom/linkarzu/dotfiles-latest
-- =============================================================================

vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
	pattern = "*",
	callback = function(args)
		local buf = args.buf or vim.api.nvim_get_current_buf()
		-- Don't format mini.files buffers
		-- tinymist panics when it receives a minifiles:// URI during formatting
		if vim.bo[buf].filetype == "minifiles" then
			return
		end
		if vim.api.nvim_buf_get_name(buf):match("^minifiles://") then
			return
		end
		-- Only format if the current mode is normal mode
		-- Only format if autoformat is enabled for the current buffer (if
		-- autoformat disabled globally the buffers inherits it, see :LazyFormatInfo)
		if LazyVim.format.enabled(buf) and vim.fn.mode() == "n" then
			-- Add a small delay to the formatting so it doesn’t interfere with
			-- CopilotChat’s or grug-far buffer initialization, this helps me to not
			-- get errors when using the "BufLeave" event above, if not using
			-- "BufLeave" the delay is not needed
			vim.defer_fn(function()
				if vim.api.nvim_buf_is_valid(buf) then
					require("conform").format({ bufnr = buf, lsp_format = "never" })
				end
			end, 100)
		end
	end,
})

return {
	"stevearc/conform.nvim",
	optional = true,
	opts = {
		formatters = {
			["markdown-toc"] = {
				condition = function(_, ctx)
					for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
						if line:find("<!%-%- toc %-%->") then
							return true
						end
					end
				end,
			},
			["markdownlint-cli2"] = {
				condition = function(_, ctx)
					local diag = vim.tbl_filter(function(d)
						return d.source == "markdownlint"
					end, vim.diagnostic.get(ctx.buf))
					return #diag > 0
				end,
			},
		},
		formatters_by_ft = {
			["javascript"] = { "prettier" },
			["typescript"] = { "prettier" },
			["javascriptreact"] = { "prettier" },
			["typescriptreact"] = { "prettier" },
			["css"] = { "prettier" },
			["html"] = { "prettier" },
			["json"] = { "prettier" },
			["yaml"] = { "prettier" },
			["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
			["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
			["lua"] = { "stylua" },
			["python"] = { "isort", "black" },
			["terraform"] = { "terraform_fmt" },
			["tf"] = { "terraform_fmt" },
			["terraform-vars"] = { "terraform_fmt" },
		},
	},
}
