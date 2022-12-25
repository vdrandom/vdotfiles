local ensure_packer = function()
    local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'lifepillar/vim-gruvbox8'

    use 'mhinz/vim-signify'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rsi'
    use 'tpope/vim-vinegar'
    use 'hoob3rt/lualine.nvim'
    use {
        'w0rp/ale',
        ft = { 'sh', 'zsh', 'lua', 'python' },
        cmd = 'ALEEnable'
    }
end)

if packer_bootstrap then
    require('packer').sync()
    return
end

require('lualine').setup { options = { icons_enabled = false } }
vim.o.bg = 'dark'
vim.o.termguicolors = true
vim.g.gruvbox_transp_bg          = 1
vim.g.gruvbox_plugin_hi_groups   = 1
vim.g.gruvbox_filetype_hi_groups = 1
vim.cmd('colorscheme gruvbox8')
