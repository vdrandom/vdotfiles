vim.o.modeline       = false
vim.o.foldmethod     = 'marker'
vim.o.cursorline     = true
vim.o.colorcolumn    = '80'
vim.o.relativenumber = true
vim.o.breakindent    = true
vim.o.clipboard      = 'unnamedplus'

vim.o.list       = true
vim.o.listchars  = 'tab:==>,nbsp:x,trail:*'

vim.o.ignorecase = true
vim.o.smartcase  = true

vim.o.scrolloff     = 3
vim.o.sidescrolloff = 15

vim.o.tabstop     = 3
vim.o.softtabstop = 4
vim.o.shiftwidth  = 4
vim.o.expandtab   = true

vim.o.keymap   = 'russian-jcukenwintype'
vim.o.iminsert = 0
vim.o.imsearch = 0

vim.o.title       = true
vim.o.titlestring = '[%{hostname()}] %t - neovim'
vim.o.statusline  = '[%F] %R%H%W%M %=[%{&fenc}/%{&ff}] %y [%4l/%L:%3v]'

vim.o.guifont     = 'JetBrainsMono Nerd Font:h14'
