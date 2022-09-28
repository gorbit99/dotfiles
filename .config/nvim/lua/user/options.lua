local options = {
  backup = false,
  cmdheight = 2,
  completeopt = { "menuone", "noselect" },
  conceallevel = 0,
  fileencoding = "utf-8",
  foldlevel = 9999,
  hlsearch = true,
  ignorecase = true,
  mouse = "",
  pumheight = 10,
  showmode = false,
  showtabline = 2,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  termguicolors = true,
  timeoutlen = 1000,
  undofile = true,
  updatetime = 300,
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  number = true,
  relativenumber = true,
  numberwidth = 4,
  signcolumn = "yes",
  wrap = true,
  scrolloff = 5,
}

vim.g.mapleader = ' '

for k, v in pairs(options) do
  vim.opt[k] = v
end
