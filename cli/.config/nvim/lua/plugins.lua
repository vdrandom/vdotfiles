-- [[ plugins list ]]
local function plugins(use)
    use 'wbthomason/packer.nvim'

    use 'lifepillar/vim-gruvbox8'
    use 'hoob3rt/lualine.nvim'
    use 'hashivim/vim-terraform'
    use 'khaveesh/vim-fish-syntax'
    use 'mhinz/vim-signify'
    use 'tpope/vim-rsi'
    use 'tpope/vim-vinegar'
    use {
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim'
    }
    use {
        'w0rp/ale',
        ft = { 'sh', 'zsh', 'lua', 'python' },
        cmd = 'ALEEnable'
    }
end

--[[ init plugins and install packer if missing ]]
if require('packer_init').init(plugins) then return end

--[[ plugins config ]]
require('lualine').setup{
    options = {
        icons_enabled = false,
        component_separators = { left = '\u{2022}', right = '\u{2022}' }
    }
}

--[[ telescope maps ]]
map('n', '<Leader>.', '<cmd>Telescope git_files<CR>')
map('n', '<Leader>,', '<cmd>Telescope buffers<CR>')

--[[ theme ]]
vim.o.bg = 'dark'
vim.o.termguicolors = true

vim.g.gruvbox_transp_bg          = 1
vim.g.gruvbox_plugin_hi_groups   = 1
vim.g.gruvbox_filetype_hi_groups = 1

vim.cmd [[colorscheme gruvbox8]]
