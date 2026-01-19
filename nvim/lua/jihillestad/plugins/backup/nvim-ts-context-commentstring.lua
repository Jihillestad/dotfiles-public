-- ==================================================================================================
-- Title: nvim-ts-context-commentstring Configuration
-- About: This file configures the nvim-ts-context-commentstring plugin for Neovim.
-- ==================================================================================================

return {
  "JoosepAlviste/nvim-ts-context-commentstring",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local tcc = require("ts_context_commentstring")

    tcc.setup({
      enable_autocmd = false,
      languages = {
        typescript = "// %s",
      },
    })
  end,
}
