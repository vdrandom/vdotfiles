require('paq') {
    'savq/paq-nvim',

    'mhinz/vim-signify',
    'tpope/vim-commentary',
    'tpope/vim-fugitive',
    'tpope/vim-rsi',
    'tpope/vim-vinegar',
    'hoob3rt/lualine.nvim',
    'w0rp/ale',

    'lifepillar/vim-gruvbox8',
    'lifepillar/vim-solarized8',
    'NLKNguyen/papercolor-theme'
}

require('lualine').setup{
    options = {
        icons_enabled        = false,
        section_separators   = { left = '', right = ''},
        component_separators = { left = '', right = ''}
    }
}

vim.g.vimwiki_list = {{path='$HOME/vimwiki/', syntax='markdown', ext='.md'}}
vim.g.PaperColor_Theme_Options = {
    theme = {
        ["default.dark"]  = { allow_bold = 1, allow_italic = 1 },
        ["default.light"] = { allow_bold = 1, allow_italic = 1 }
    }
}

vim.o.bg = 'dark'
vim.o.termguicolors = true
vim.g.gruvbox_filetype_hi_groups = 1
vim.cmd('colorscheme gruvbox8')
