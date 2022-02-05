local cmd = vim.cmd;

cmd 'color sonokai'
cmd 'packadd termdebug'

vim.g.termdebug_wide = 1

vim.g.fold_options = {
    ['fallback_method'] = { ['line_threshold'] = 2000, ['method'] = 'syntax' },
    ['fold_blank'] = 0,
    ['fold_includes'] = 0,
    ['max_foldline_length'] = 'win',
    ['merge_comments'] = 1,
    ['show_if_and_else'] = 1,
    ['strip_namespaces'] = 1,
    ['strip_template_arguments'] = 1
}

vim.o.autoindent = true
vim.o.backupcopy = "yes"
vim.o.bg = "dark"
vim.opt.backspace = {"indent", "eol", "start"}
vim.o.colorcolumn = "+1"
vim.o.emo = true
vim.o.equalalways = true
vim.o.expandtab = true
vim.o.fileignorecase = true
vim.o.foldlevelstart= 99
vim.o.foldmethod="marker"
vim.o.hidden = true
vim.o.history = 1000
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.inccommand = "nosplit"
vim.o.incsearch = true
vim.o.linebreak = true
vim.o.mouse = ""
vim.o.compatible = false
vim.o.errorbells = false
vim.o.number = true
vim.o.numberwidth = 3
vim.o.relativenumber = true
vim.o.ruler = true
vim.o.scrolloff = 5
vim.o.shiftround = true
vim.o.shiftwidth = 4
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.softtabstop = -1
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.textwidth = 80
vim.o.title = true
vim.o.wildignorecase = true
vim.o.wildignore = vim.o.wildignore .. "*/tmp/*,*.so,*.swp"
vim.o.wildmenu = true
vim.o.signcolumn = "yes"
vim.o.conceallevel = 1
vim.o.concealcursor = ""
