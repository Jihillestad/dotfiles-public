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
