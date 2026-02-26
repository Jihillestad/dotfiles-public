-- ==================================================================================================
-- Title: Bufferline Configuration
-- About: This file configures the bufferline.nvim plugin for Neovim.
-- ==================================================================================================

return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- version = "*",
  opts = {
    options = {
      mode = "tabs",
      separator_style = "slant",
    },
  },
}
