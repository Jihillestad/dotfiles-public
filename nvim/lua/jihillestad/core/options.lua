-- ================================================
-- Title: Neovim Options Configuration
-- About: Basic settings and preferences for Neovim
-- ================================================

local opt = vim.opt -- for conciseness

-- Basic Settings
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)
opt.wrap = false -- disable line wrapping
opt.cursorline = true -- highlight the current cursor line
opt.scrolloff = 10 -- keep 10 lines above and below the cursor
opt.sidescrolloff = 8 -- keep 10 columns to the left and right of the cursor
opt.cmdheight = 1 -- Command line height
opt.spelllang = { "en", "nb" } -- set spellcheck languages to english and norwegian bokmål

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.softtabstop = 2 -- 2 spaces for a tab
opt.expandtab = true -- expand tab to spaces
opt.smartindent = true -- autoindent new lines
opt.autoindent = true -- copy indent from current line when starting new one
opt.grepprg = "rg --vimgrep" -- Use ripgrep if available
opt.grepformat = "%f:%l:%c:%m" -- filename, line number, column, content

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
opt.hlsearch = false -- don't highlight all matches on previous search pattern
opt.incsearch = true -- show search matches as you type

-- appearance
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift
opt.pumheight = 10 -- pop up menu height
opt.pumblend = 10 -- pop up menu transparency
opt.winblend = 10 -- floating window transparency
-- opt.colorcolumn = "100" -- line length marker at 100 characters
opt.conceallevel = 0 -- Don't hide markup
opt.concealcursor = "" -- Show markup even on cursor line
opt.lazyredraw = false -- redraw while executing macros (butter UX)
opt.redrawtime = 10000 -- Timeout for syntax highlighting redraw
opt.maxmempattern = 20000 -- Max memory for pattern matching
opt.synmaxcol = 300 -- Syntax highlighting column limit

-- Make SignColumn transparent
vim.cmd([[
  augroup TransparentColorColumn
    autocmd!
    autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
  augroup END
]])

-- Behavior settingds
opt.errorbells = false -- disable error bells
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
opt.autochdir = false -- do not change cwd automatically
opt.clipboard:append("unnamedplus") -- use system clipboard as default register
opt.iskeyword:append("-") -- Treat dash as part of a word
opt.path:append("**") -- Search into subfolders with `gf`
opt.selection = "inclusive" -- Use inclusive selection
opt.mouse = "a" -- enable mouse support in all modes
opt.encoding = "UTF-8" -- Use UTF-8 encoding
opt.wildmenu = true -- Enable command-line completion menu
opt.wildmode = "longest:full,full" -- Completion mode for command-line
opt.wildignorecase = true -- Case-insensitive tab completion in commands

-- Cursor Settings
opt.guicursor = {
  "n-v-c:block", -- Normal, Visual, Command-line
  "i-ci-ve:block", -- Insert, Command-line Insert, Visual-exclusive
  "r-cr:hor20", -- Replace, Command-line Replace
  "o:hor50", -- Operator-pending
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor", -- All modes: blinking & highlight groups
  "sm:block-blinkwait175-blinkoff150-blinkon175", -- Showmatch mode
}

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- Folding Settings
opt.foldmethod = "expr" -- Use expression for folding
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use treesitter for folding
opt.foldlevel = 99 -- Keep all folds open by default

-- File Handling
opt.swapfile = false

-- HACK: make sure docker-compose.yaml is set as a yaml.docker-compose file. Or else docker_compose_language server wont attach to the buffer
function docker_fix()
  local Filename = vim.fn.expand("%:t")

  if Filename == "docker-compose.yaml" then
    vim.bo.filetype = "yaml.docker-compose"
    print("matched!")
  else
    print(Filename)
  end
end

vim.cmd([[au BufRead * lua docker_fix()]])
