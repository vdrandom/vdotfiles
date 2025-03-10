-- [[ plugins bootstrap ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyurl = "https://github.com/folke/lazy.nvim.git"
local lazycmd = {"git", "clone", "--filter=blob:none", "--branch=stable", lazyurl, lazypath}
if not vim.loop.fs_stat(lazypath) then vim.fn.system(lazycmd) end
vim.opt.rtp:prepend(lazypath)

--[[ plugins list ]]
require('lazy').setup {
    {'ellisonleao/gruvbox.nvim', priority = 1000, config = true},
    {'w0rp/ale', cmd = 'ALEEnable', ft = {'bash', 'go', 'lua', 'python', 'sh', 'zsh'}},
    'smoka7/hop.nvim',
    'kdheepak/lazygit.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-treesitter/nvim-treesitter',
    'lewis6991/gitsigns.nvim',
    'lifepillar/vim-cheat40',
    'nvim-lualine/lualine.nvim',
    'tpope/vim-rsi',
    'tpope/vim-vinegar',
    {'nvim-lua/plenary.nvim', lazy = true},
}

--[[ plugin configs and maps ]]
require('hop').setup()
require('gitsigns').setup()
require('gruvbox').setup {
    italic = {strings = false},
    terminal_colors = true
}
require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true
    }
}
require('lualine').setup {
  options = {
    icons_enabled = false,
    section_separators = {left = nil, right = nil},
    component_separators = {left = "\u{2022}", right = "\u{2022}"}
  }
}

map('n', '<Leader>f', '<cmd>HopWord<CR>')
map('n', '<Leader>g', '<cmd>LazyGit<CR>')
map('n', '<Leader>L', '<cmd>Lazy<CR>')
map('n', '<Leader>?', '<cmd>Cheat40<CR>')
map('n', '<Leader>.', '<cmd>Telescope git_files<CR>')
map('n', '<Leader>,', '<cmd>Telescope buffers<CR>')

--[[ theme ]]
vim.o.termguicolors = true
vim.o.bg = 'dark'

vim.cmd [[colorscheme gruvbox]]
