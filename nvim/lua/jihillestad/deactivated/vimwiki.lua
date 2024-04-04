return {
  "vimwiki/vimwiki",
  event = "BufEnter *.md",
  keys = { "<leader>ww", "<leader>wt" },
  init = function()
    vim.g.vimwiki_folding = ""
    vim.g.vimwiki_global_ext = 0
    --   vim.g.vimwiki_list = {
    --     {
    --       path = "~/projects/vault/",
    --       syntax = "markdown",
    --       ext = ".md",
    --     },
    --   }
    --   vim.g.vimwiki_ext2syntax = {
    --     [".md"] = "markdown",
    --     [".markdown"] = "markdown",
    --     [".mdown"] = "markdown",
    --   }
  end,
}
