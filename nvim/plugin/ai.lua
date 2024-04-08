-- use {
--   'zbirenbaum/copilot.lua',
--   cmd = 'Copilot',
--   event = 'InsertEnter',
--   config = function()
--     require('copilot').setup {}
--   end,
-- }

vim.api.nvim_create_autocmd('InsertEnter', {
  group = vim.api.nvim_create_augroup('Copilot', {}),
  callback = function()
    require('copilot').setup { suggestion = { enabled = false }, panel = { enabled = false } }
    require('copilot_cmp').setup()

    require('ollama').setup { url = 'http://desktop.lan:11434' }
  end,
})
