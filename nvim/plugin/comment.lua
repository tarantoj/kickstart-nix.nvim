require('neogen').setup {
  snippet_engine = 'luasnip',
  languages = {
    cs = { template = { annotation_convention = 'xmldoc' } },
  },
}

vim.keymap.set('n', '<Leader>ng', require('neogen').generate, { desc = '[neogen] generate' })
