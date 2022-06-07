lua require('_plugins')
lua require('_options')
lua require('_autocommands')
lua require('_mappings')


augroup misc
    au!
    autocmd FileType cpp setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

augroup Filetypes
    autocmd!
   
    au FileType json set tabstop=2
    au FileType json set shiftwidth=2

    au FileType css,scss set tabstop=2
    au FileType css,scss set shiftwidth=2

    au FileType html,html.handlebars set tabstop=2
    au FileType html,html.handlebars set shiftwidth=2

    au FileType brainfuck set tabstop=2
    au FileType brainfuck set shiftwidth=2

    au FileType javascript set tabstop=2
    au FileType javascript set shiftwidth=2
    au FileType typescript set tabstop=2
    au FileType typescript set shiftwidth=2
    
    au FileType graphql set shiftwidth=2
    au FileType graphql set tabstop=2

    au FileType lua set tabstop=2 shiftwidth=2
augroup END

augroup lsp
    autocmd!
    autocmd BufWritePre *.h,*.c,*.cpp,*.ts,*.html,*.hbs,*.scss lua vim.lsp.buf.formatting_seq_sync()
    autocmd BufWritePre *.js,*.php,*.lua lua vim.lsp.buf.formatting_seq_sync()
    autocmd BufWritePre *.ts,*.js :EslintFixAll
augroup END

augroup floaterm
    autocmd VimEnter * FloatermNew --silent
augroup END

nnoremap <silent> <leader>tt :FloatermToggle<CR><C-\><C-n>
nnoremap <silent> <leader>to :FloatermNew<CR><C-\><C-n>
nnoremap <silent> <leader>tp :FloatermNext<CR><C-\><C-n>
nnoremap <silent> <leader>tn :FloatermPrev<CR><C-\><C-n>
nnoremap <silent> <leader>tk :FloatermKill<CR>
