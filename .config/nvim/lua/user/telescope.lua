local telescope = require('telescope')

telescope.setup {}
telescope.load_extension('projects')

local builtin = require 'telescope.builtin'

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>ft', builtin.treesitter, {})
vim.keymap.set('n', '<leader>fp', telescope.extensions.projects.projects, {})
vim.keymap.set('n', '<leader>orc', function()
  builtin.find_files {
    cwd = vim.fn.stdpath("config")
  }
end, {})
