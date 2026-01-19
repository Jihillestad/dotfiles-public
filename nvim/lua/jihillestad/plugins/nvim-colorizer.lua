-- ==================================================================================================
-- Title: nvim-colorizer.lua Configuration
-- About: This file configures the nvim-colorizer.lua plugin for Neovim.
-- ==================================================================================================

return {
  "NvChad/nvim-colorizer.lua",
  event = { "BufReadPre", "BufNewFile" },
  config = true,
  opts = {
    user_default_options = {
      tailwind = true,
    },
  },
}
