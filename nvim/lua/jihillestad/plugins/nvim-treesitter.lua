-- ==============================================================================
-- Title: nvim-treesitter Configuration
-- About: This file configures the nvim-treesitter plugin for Neovim.
-- ==============================================================================

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,

    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require("nvim-treesitter")

      treesitter.install({
        "json",
        "vimdoc",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "prisma",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "hcl",
        "terraform",
        "python",
        "powershell",
      })
    end,
  },
}
