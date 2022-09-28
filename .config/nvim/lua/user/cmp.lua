local cmp = require('cmp')
local luasnip = require 'luasnip'

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources(
    { { name = 'nvim_lsp' }, { name = 'luasnip' } },
    { { name = 'buffer' } }
  ),
})

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources(
    { { name = 'cmp_git' } },
    { { name = 'buffer' } }
  )
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
    { { name = 'buffer' } }
  )
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
    { { name = 'path' } },
    { { name = 'cmdline' } }
  ),
})

local opts = { noremap=true, silent=true }
vim.keymap.set('i', '<C-j>', function()
  if luasnip.jumpable(1) then luasnip.jump(1) end
end, opts)
vim.keymap.set('i', '<C-k>', function()
  if luasnip.jumpable(-1) then luasnip.jump(-1) end
end, opts)
vim.keymap.set('i', '<C-h>', function()
  if luasnip.choice_active() then luasnip.change_choice(1) end
end, opts)
vim.keymap.set('i', '<C-l>', function()
  if luasnip.choice_active() then luasnip.change_choice(-1) end
end, opts)
