-- [[ plugins list ]]
local function plugins(use)
    use 'wbthomason/packer.nvim'

    use {
        'lifepillar/vim-solarized8',
        branch = 'neovim'
    }
    use 'lifepillar/vim-cheat40'
    use 'hoob3rt/lualine.nvim'
    use 'hashivim/vim-terraform'
    use 'khaveesh/vim-fish-syntax'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'mhinz/vim-signify'
    use 'tpope/vim-rsi'
    use 'tpope/vim-vinegar'
    use {
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim'
    }
    use {
        'w0rp/ale',
        ft = { 'bash', 'sh', 'zsh', 'lua', 'python' },
        cmd = 'ALEEnable'
    }
end

--[[ init plugins and install packer if missing ]]
if require('packer_init').init(plugins) then return end

--[[ plugin configs ]]
require('lualine').setup{
    options = {
        icons_enabled = false,
        section_separators = { left = nil, right = nil },
        component_separators = { left = '\u{2022}', right = '\u{2022}' }
    }
}

--[[ plugin maps ]]
map('n', '<Leader>?', '<cmd>Cheat40<CR>')
map('n', '<Leader>.', '<cmd>Telescope git_files<CR>')
map('n', '<Leader>,', '<cmd>Telescope buffers<CR>')

--[[ theme ]]
vim.g.solarized_extra_hi_groups = 1
vim.o.termguicolors = true
vim.o.bg = 'light'

vim.cmd [[colorscheme solarized8]]
