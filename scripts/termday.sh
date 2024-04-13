#!/bin/bash

sed -i "" "s/import = \[\"~\/\.config\/alacritty\/themes\/themes\/tokyo-night\.toml\"\]/import = \[\"~\/\.config\/alacritty\/themes\/themes\/tokyonight_day\.toml\"\]/" $DOTFILES/alacritty.toml
#

sed -i '' 's/style = "night",/style = "day",/' $DOTFILES/nvim/lua/jihillestad/plugins/colorscheme.lua

sed -i '' '/on_colors = function(colors)/s/^/--/g' $DOTFILES/nvim/lua/jihillestad/plugins/colorscheme.lua
sed -i '' '/colors.bg = bg/s/^/--/g' $DOTFILES/nvim/lua/jihillestad/plugins/colorscheme.lua
sed -i '' '/colors.bg_dark = bg_dark/s/^/--/g' $DOTFILES/nvim/lua/jihillestad/plugins/colorscheme.lua
sed -i '' '/colors.bg_float = bg_dark/s/^/--/g' $DOTFILES/nvim/lua/jihillestad/plugins/colorscheme.lua
sed -i '' '/colors.bg_highlight = bg_highlight/s/^/--/g' $DOTFILES/nvim/lua/jihillestad/plugins/colorscheme.lua
sed -i '' '/colors.bg_popup = bg_dark/s/^/--/g' $DOTFILES/nvim/lua/jihillestad/plugins/colorscheme.lua
sed -i '' '/colors.bg_search = bg_search/s/^/--/g' $DOTFILES/nvim/lua/jihillestad/plugins/colorscheme.lua
sed -i '' '/colors.bg_sidebar = bg_dark/s/^/--/g' $DOTFILES/nvim/lua/jihillestad/plugins/colorscheme.lua
sed -i '' '/colors.bg_statusline = bg_dark/s/^/--/g' $DOTFILES/nvim/lua/jihillestad/plugins/colorscheme.lua
sed -i '' '/colors.bg_visual = bg_visual/s/^/--/g' $DOTFILES/nvim/lua/jihillestad/plugins/colorscheme.lua
sed -i '' '/colors.border = border/s/^/--/g' $DOTFILES/nvim/lua/jihillestad/plugins/colorscheme.lua
sed -i '' '/colors.fg = fg/s/^/--/g' $DOTFILES/nvim/lua/jihillestad/plugins/colorscheme.lua
sed -i '' '/colors.fg_dark = fg_dark/s/^/--/g' $DOTFILES/nvim/lua/jihillestad/plugins/colorscheme.lua
sed -i '' '/colors.fg_float = fg/s/^/--/g' $DOTFILES/nvim/lua/jihillestad/plugins/colorscheme.lua
sed -i '' '/colors.fg_gutter = fg_gutter/s/^/--/g' $DOTFILES/nvim/lua/jihillestad/plugins/colorscheme.lua
sed -i '' '/colors.fg_sidebar = fg_dark/s/^/--/g' $DOTFILES/nvim/lua/jihillestad/plugins/colorscheme.lua
sed -i '' '/end, -- End color override/s/^/--/' $DOTFILES/nvim/lua/jihillestad/plugins/colorscheme.lua
      # })
# sed -i '' '/local testvalue = "test"/s/^/--/g' dummy.lua
