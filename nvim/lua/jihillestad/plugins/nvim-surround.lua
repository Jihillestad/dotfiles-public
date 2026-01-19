-- ==================================================================================================
-- Title: nvim-surround Configuration
-- About: This file configures the nvim-surround plugin for managing surrounding characters in
-- Neovim.
-- ==================================================================================================

return {
  "kylechui/nvim-surround",
  event = { "BufReadPre", "BufNewFile" },
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  config = true,
}
