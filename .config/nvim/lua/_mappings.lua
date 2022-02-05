vim.g.mapleader = " "

-- VIMRC

vim.api.nvim_set_keymap('n', '<leader>rc', ':source ~/.config/nvim/init.vim<CR>',
    {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>orc', ':sp ~/.config/nvim/init.vim<CR>',
    {noremap = true, silent = true})

-- TERMINAL

vim.api.nvim_set_keymap('n', '<c-x><c-l>', ':set scrollback=1 | sleep 100m | set scrollback=10000<cr>',
    {noremap = true, silent = true})

vim.api.nvim_set_keymap('t', '<c-x><c-l>', '<c-\\><c-n><c-w><c-l>i<c-l>',
    {noremap = true, silent = true})

-- TODOLOCLIST

vim.api.nvim_set_keymap('n', '<leader>tl', ':TodoLocList<CR>',
    {noremap = true, silent = true})
