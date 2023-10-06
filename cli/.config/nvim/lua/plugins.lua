-- [[ plugins bootstrap ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyurl = "https://github.com/folke/lazy.nvim.git"
local lazycmd = { "git", "clone", "--filter=blob:none", "--branch=stable", lazyurl, lazypath }
if not vim.loop.fs_stat(lazypath) then vim.fn.system(lazycmd) end
vim.opt.rtp:prepend(lazypath)

--[[ plugins list ]]
require('lazy').setup {
    {'lifepillar/vim-solarized8', branch = 'neovim'},
    {'nvim-telescope/telescope.nvim', dependencies = {'nvim-lua/plenary.nvim'}},
    {'nvim-treesitter/nvim-treesitter', cmd = 'TSUpdate'},
    {'w0rp/ale', cmd = 'ALEEnable', ft = {'bash', 'sh', 'zsh', 'lua', 'python'}},
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

--[[ theme ]]
vim.g.solarized_extra_hi_groups = 1
vim.g.solarized_t_Co = 16
vim.o.termguicolors = false
vim.o.bg = 'light'

vim.cmd [[colorscheme solarized8]]
