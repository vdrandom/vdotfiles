-- [[ plugins list ]]
plugins = function(use)
    use 'wbthomason/packer.nvim'

    use 'lifepillar/vim-gruvbox8'
    use 'hoob3rt/lualine.nvim'
    use 'mhinz/vim-signify'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rsi'
    use 'tpope/vim-vinegar'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use {
        'w0rp/ale',
        ft = { 'sh', 'zsh', 'lua', 'python' },
        cmd = 'ALEEnable'
    }
end

--[[ init packer if missing ]]
if require('packer_init') then return end

--[[ plugins config ]]
require('lualine').setup()

--[[ telescope maps ]]
map('n', '<Leader>ff', '<cmd>Telescope find_files<CR>')
map('n', '<Leader>fb', '<cmd>Telescope buffers<CR>')

--[[ theme ]]
vim.o.bg = 'dark'
vim.o.termguicolors = true

--vim.g.gruvbox_transp_bg        = 1
vim.g.gruvbox_plugin_hi_groups   = 1
vim.g.gruvbox_filetype_hi_groups = 1

vim.cmd [[colorscheme gruvbox8]]
