-- =============================================================================
-- Title: constants.lua
-- File: ~/repos/github.com/jihillestad/dotfiles/wezterm/constants.lua
-- About: Setting constants separately from the main config file
-- Credits: A special thanks to Lazar Nikoloc for providing his dotfiles
-- Sources:
-- - http://github.com/nikolovlazar/dotfiles
-- =============================================================================
local M = {}

M.bg_blurry = os.getenv("HOME") .. "/repos/github.com/jihillestad/dotfiles/wezterm/assets/bg-blurry.png"
M.bg_blurry_darker = os.getenv("HOME") .. "/repos/github.com/jihillestad/dotfiles/wezterm/assets/bg-blurry-darker.png"
M.bg_blurry_darkest = os.getenv("HOME") .. "/repos/github.com/jihillestad/dotfiles/wezterm/assets/bg-blurry-darkest.png"
M.bg_image = M.bg_blurry_darkest

return M
