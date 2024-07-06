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

    if require('copilot').sessionid ~= nil then
      require('CopilotChat').setup {}
    end

    vim.keymap.set('n', '<leader>ccq', function()
      local input = vim.fn.input('Quick Chat: ')
      if input ~= '' then
        require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
      end
    end, { desc = 'CopilotChat - Quick chat' })

    vim.keymap.set('n', '<leader>cch', function()
      local actions = require('CopilotChat.actions')
      require('CopilotChat.integrations.telescope').pick(actions.help_actions())
    end, { desc = 'CopilotChat - Help actions' })

    vim.keymap.set('n', '<leader>ccp', function()
      local actions = require('CopilotChat.actions')
      require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
    end, { desc = 'CopilotChat - Prompt actions' })

    require('ollama').setup { url = 'http://desktop.kudu-tone.ts.net:11434' }
  end,
})
