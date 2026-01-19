-- ==================================================================================================
-- Title: GitHub Copilot Plugin Configuration
-- About: This file configures the GitHub Copilot plugin for Neovim.
-- ==================================================================================================

return {
  {
    "github/copilot.vim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
  },
}
