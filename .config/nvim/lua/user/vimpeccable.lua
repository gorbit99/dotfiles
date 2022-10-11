local vimp = require('vimp')

vim.keymap.set('n', '<leader>rc', function()
  vimp.unmap_all()

  -- vim.cmd(string.format('runtime! %s/lua/user/**/*.lua', vim.fn.stdpath('config')))
  require('plenary.reload').reload_module('user', false)
  require('plenary.reload').reload_module('init', false)
  vim.cmd('luafile $MYVIMRC')
end, { silent = true, noremap = true })
