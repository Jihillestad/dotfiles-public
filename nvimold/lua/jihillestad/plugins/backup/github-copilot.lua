-- ==================================================================================================
-- Title: GitHub Copilot Plugin Configuration
-- About: This file configures the GitHub Copilot plugin for Neovim.
-- ==================================================================================================

return {
  {
    "github/copilot.vim",
    enabled = false,
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
  },
}
