vim.g.mapleader = ' '

function map(mode, key, action)
    vim.api.nvim_set_keymap(mode, key, action, {noremap = true})
end
function unmap(key)
    map('', key, '')
end

-- some unmaps
unmap(' ')
unmap('q')
unmap('<F1>')

-- option control
map('n', '<Leader>c', ':setlocal cursorline!<CR>')
map('n', '<Leader>l', ':setlocal list!<CR>')
map('n', '<Leader>w', ':setlocal wrap!<CR>')

-- search
map('n', '<Leader>/', ':noh<CR>')

-- copy / paste
map('n', '<Leader>y', '"+y')
map('n', '<Leader>d', '"+d')
map('n', '<Leader>p', '"+p')
map('n', '<Leader>P', '"+P')

-- keymap switch
map('!', '<C-Space>', '<C-^>')
map('!', '<C-@>', '<C-^>')
