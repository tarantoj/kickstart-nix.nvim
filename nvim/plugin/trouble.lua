-- Lua
vim.keymap.set('n', '<leader>xx', function()
  require('trouble').toggle('diagnostics')
end, { desc = 'problems' })
vim.keymap.set('n', '<leader>xw', function()
  require('trouble').toggle('workspace_diagnostics')
end, { desc = 'workspace diagnostics' })
vim.keymap.set('n', '<leader>xd', function()
  require('trouble').toggle('document_diagnostics')
end, { desc = 'document diagnostics' })
vim.keymap.set('n', '<leader>xq', function()
  require('trouble').toggle('quickfix')
end, { desc = 'quickfix' })
vim.keymap.set('n', '<leader>xl', function()
  require('trouble').toggle('loclist')
end, { desc = 'loclist' })
vim.keymap.set('n', 'gR', function()
  require('trouble').toggle('lsp_references')
end, { desc = 'lsp references' })

local actions = require('telescope.actions')
local open_with_trouble = require('trouble.sources.telescope').open

-- Use this to add more results without clearing the trouble list
local add_to_trouble = require('trouble.sources.telescope').add

local telescope = require('telescope')

telescope.setup {
  defaults = {
    mappings = {
      i = { ['<c-t>'] = open_with_trouble },
      n = { ['<c-t>'] = open_with_trouble },
    },
  },
}
