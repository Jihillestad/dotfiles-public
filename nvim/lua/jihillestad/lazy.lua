local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "jihillestad.plugins" }, { import = "jihillestad.plugins.lsp" } }, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})

-- function SetTermColors()
--   --   vim.g.nightflyTransparent = true
--   vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--   vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
--   vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--   vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
--   vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
--   vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
--   vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "none" })
-- end
-- SetTermColors()

vim.g.skip_ts_context_commentstring_module = true
