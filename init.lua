require('plugins.init')

vim.g.mapleader = ";"
vim.cmd("filetype plugin on")
vim.cmd("filetype indent on")
vim.cmd[[command! W w !sudo tee % > /dev/null]]

vim.g.colors_name = 'tokyonight'
vim.o.termguicolors = true

vim.o.syntax = 'on'

-- Sets how many lines of history VIM has to remember
vim.o.history = 500
-- Line numbers related
vim.o.number = true
-- Set 7 lines to the cursor - when moving vertically using j/k
vim.o.so = 7
-- Always show current position
vim.o.ruler = true
-- A buffer becomes hidden when it is abandoned
vim.o.hid = true
-- Configure backspace so it acts as it should act
vim.o.backspace = 'eol,start,indent'
vim.o.whichwrap = vim.o.whichwrap .. '<,>,h,l'
-- When searching try to be smart about cases 
vim.o.smartcase = true
-- Highlight search results
vim.o.hlsearch = true
-- Makes search act like search in modern browsers
vim.o.incsearch = true
-- For regular expressions turn magic on
vim.o.magic = true
-- Show matching brackets when text indicator is over them
vim.o.showmatch = true
-- How many tenths of a second to blink when matching brackets
vim.o.mat = 2
-- Add a bit extra margin to the left
vim.o.foldcolumn = '1'

vim.o.lazyredraw = true

vim.o.background = 'dark'
-- Set utf8 as standard encoding and en_US as the standard language
vim.o.encoding = 'utf8'
-- Use Unix as the standard file type
vim.o.ffs = 'unix,dos,mac'
-- Use spaces instead of tabs
vim.o.expandtab = true
-- Be smart when using tabs ;)
vim.o.smarttab = true
-- 1 tab == 4 spaces
vim.o.shiftwidth = 4
vim.o.tabstop = 4
-- Linebreak on 500 characters
vim.o.lbr = true
vim.o.tw = 500
-- Auto indent
vim.o.ai = true
-- Smart indent
vim.o.si = true
-- Wrap lines
vim.o.wrap = true
-- No backup files
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
-- Save undo history
vim.o.undofile = true

vim.o.clipboard = 'unnamedplus'
vim.o.inccommand = 'nosplit'

-- Use faster grep alternatives if possible
if vim.fn.executable('rg') then
    vim.o.grepprg =
        [[rg --hidden --glob "!.git" --no-heading --smart-case --vimgrep --follow $*]]
    vim.o.grepformat = '%f:%l:%c:%m' .. vim.o.grepformat
end

-- highlight yanked text briefly
vim.cmd [[autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="Search", timeout=250, on_visual=false}]]

-- Ctrl+\ => open definition in a vertical splited window
vim.api.nvim_set_keymap('n', '<C-\\>', ':vsp <CR><C-]><CR>', {silent = true})

vim.g.go_def_mode='gopls'
vim.g.go_info_mode='gopls'
