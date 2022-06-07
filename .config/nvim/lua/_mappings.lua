vim.g.mapleader = " "
local vimp = require'vimp'

-- VIMRC

vimp.nnoremap({'silent'}, '<leader>rc',  ':source ~/.config/nvim/init.vim<CR>');

-- TERMINAL

vimp.nnoremap({'silent'}, '<C-x><C-l>', ':set scrollback=1 | sleep 100m | set scrollback=10000<cr>');

vimp.tnoremap({'silent'}, '<C-x><C-l>', '<c-\\><c-n><c-w><c-l>i<c-l>');

-- TELESCOPE

local telescope_builtins = require'telescope.builtin'

vimp.nnoremap({'silent'}, '<leader>orc', function ()
  telescope_builtins.find_files({cwd="~/.config/nvim/"})
end)
