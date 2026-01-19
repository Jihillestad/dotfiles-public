-- ==================================================================================================
-- Title: Indent Blankline Configuration
-- About: This file configures the indent-blankline.nvim plugin for Neovim to display
-- indentation levels.
-- ==================================================================================================

return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  opts = {
    indent = { char = "┊" },
  },
}
