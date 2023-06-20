-- [[ plugins list ]]
local function plugins(use)
    use 'wbthomason/packer.nvim'

    use 'lifepillar/vim-gruvbox8'
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

--[[ plugins config ]]
if os.getenv('TERM'):match('linux') then
    lualine_section_separators = { left = nil, right = nil }
    lualine_component_separators = { left = '|', right = '|' }
else
    lualine_section_separators = nil
    lualine_component_separators = { left = '\u{2022}', right = '\u{2022}' }
end
require('lualine').setup{
    options = {
        icons_enabled = false,
        section_separators = lualine_section_separators,
        component_separators = lualine_component_separators
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
