return {
  "lervag/vimtex",
  init = function()
    vim.g.vimtex_view_method = "skim"
    vim.g.vimtex_skim_sync = 1
    vim.g.vimtex_skim_activate = 1

    local au_group = vim.api.nvim_create_augroup("vimtex_events", {})

    vim.api.nvim_create_autocmd("User", {
      pattern = "VimtexEventQuit",
      group = au_group,
      command = "VimtexClean",
    })
  end,
}
