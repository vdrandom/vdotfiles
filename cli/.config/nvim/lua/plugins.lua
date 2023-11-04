-- [[ plugins bootstrap ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyurl = "https://github.com/folke/lazy.nvim.git"
local lazycmd = {"git", "clone", "--filter=blob:none", "--branch=stable",
                 lazyurl, lazypath}
if not vim.loop.fs_stat(lazypath) then vim.fn.system(lazycmd) end
vim.opt.rtp:prepend(lazypath)

--[[ plugins list ]]
require('lazy').setup {
    {'lifepillar/vim-gruvbox8', branch = 'neovim'},
    {'lifepillar/vim-solarized8', branch = 'neovim'},
    {'nvim-telescope/telescope.nvim', dependencies = {'nvim-lua/plenary.nvim'}},
    {'nvim-treesitter/nvim-treesitter', cmd = 'TSUpdate'},
    {'w0rp/ale', cmd = 'ALEEnable', ft = {'bash', 'go', 'lua', 'python', 'sh', 'zsh'}},
    'lewis6991/gitsigns.nvim',
    'lifepillar/vim-cheat40',
    'tpope/vim-rsi',
    'tpope/vim-vinegar',
}

--[[ plugin configs and maps ]]
require('gitsigns').setup()
require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true
    }
}

map('n', '<Leader>L', '<cmd>Lazy<CR>')
map('n', '<Leader>?', '<cmd>Cheat40<CR>')
map('n', '<Leader>.', '<cmd>Telescope git_files<CR>')
map('n', '<Leader>,', '<cmd>Telescope buffers<CR>')
map('n', '<Leader>T', '<cmd>colorscheme solarized8|set bg=light<CR>')
map('n', '<Leader>t', '<cmd>colorscheme gruvbox8|set bg=dark<CR>')

--[[ theme ]]
vim.g.solarized_extra_hi_groups  = 1
vim.g.gruvbox_plugin_hi_groups   = 1
vim.g.gruvbox_filetype_hi_groups = 1
vim.o.termguicolors = true
vim.o.bg = 'dark'

vim.cmd [[colorscheme gruvbox8]]
