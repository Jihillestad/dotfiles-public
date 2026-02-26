require("config.lazy")

-- bullets.vim has a known issue where it can interfere with the new snacks
-- picker by folke, preventing you from selecting a file with <CR> when in
-- insert mode. To mitigate this, you can disable bullets in empty buffers by
-- adding the following line to your init.lua:
-- vim.g.bullets_enable_in_empty_buffers = 0
