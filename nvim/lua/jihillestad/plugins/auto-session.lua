return {
  "rmagatti/auto-session",
  config = function()
    -- Fix sessionoptions for auto-session
    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

    local auto_session = require("auto-session")
    auto_session.setup({
      auto_restore = false, -- Updated from auto_restore_enabled
      suppressed_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" }, -- Updated from auto_session_suppress_dirs
    })

    local keymap = vim.keymap
    keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
    keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
  end,
}
