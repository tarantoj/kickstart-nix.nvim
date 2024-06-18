require('neotest').setup {
  adapters = {
    require 'neotest-jest' {},
    require 'neotest-dotnet' {
      dap = {
        -- Extra arguments for nvim-dap configuration
        -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
        args = { justMyCode = false },
        -- Enter the name of your dap adapter, the default value is netcoredbg
        adapter_name = 'coreclr',
      },
    },
  },
}

local keymap = vim.keymap

-- keymap.set('n', "<leader>tt",
keymap.set('n', '<leader>tt', function()
  require('neotest').run.run(vim.fn.expand '%')
end, { desc = 'Run File' })
keymap.set('n', '<leader>tT', function()
  require('neotest').run.run(vim.uv.cwd())
end, { desc = 'Run All Test Files' })
keymap.set('n', '<leader>tr', function()
  require('neotest').run.run()
end, { desc = 'Run Nearest' })
keymap.set('n', '<leader>tl', function()
  require('neotest').run.run_last()
end, { desc = 'Run Last' })
keymap.set('n', '<leader>ts', function()
  require('neotest').summary.toggle()
end, { desc = 'Toggle Summary' })
keymap.set('n', '<leader>to', function()
  require('neotest').output.open { enter = true, auto_close = true }
end, { desc = 'Show Output' })
keymap.set('n', '<leader>tO', function()
  require('neotest').output_panel.toggle()
end, { desc = 'Toggle Output Panel' })
keymap.set('n', '<leader>tS', function()
  require('neotest').run.stop()
end, { desc = 'Stop' })

require('which-key').register { ['<leader>t'] = { name = '+test' } }
