local vimp = require("vimp")

vimp.nnoremap({'silent', 'buffer'}, '<leader>ca', ':RustCodeAction<cr>')
vimp.nnoremap({'silent', 'buffer'}, '<leader>rr', ':RustRunnables<cr>')
