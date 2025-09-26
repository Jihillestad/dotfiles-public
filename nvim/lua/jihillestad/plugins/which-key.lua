return {
  "folke/which-key.nvim",
  dependencies = {
    { "nvim-mini/mini.icons", version = "*" },
    "nvim-tree/nvim-web-devicons", -- optional
  },
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    defaults = {
      ["<localleader>l"] = { name = "+vimtex" },
    },
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
}
