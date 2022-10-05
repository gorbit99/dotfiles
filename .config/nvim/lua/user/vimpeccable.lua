local vimp = require('vimp')

vim.keymap.set('n', '<leader>rc', function()
  vimp.unmap_all()

  vim.cmd('luafile %')
end, { silent = true, noremap = true })
