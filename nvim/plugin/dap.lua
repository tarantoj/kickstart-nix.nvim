local dap = require 'dap'

require('dapui').setup()

dap.adapters.coreclr = {
  type = 'executable',
  command = 'netcoredbg',
  args = { '--interpreter=vscode' },
}

vim.g.dotnet_build_project = function()
  local default_path = vim.fn.getcwd() .. '/'
  if vim.g['dotnet_last_proj_path'] ~= nil then
    default_path = vim.g['dotnet_last_proj_path']
  end
  local path = vim.fn.input('Path to your *proj file', default_path, 'file')
  vim.g['dotnet_last_proj_path'] = path
  local cmd = 'dotnet build -c Debug ' .. path .. ' > /dev/null'
  print ''
  print('Cmd to execute: ' .. cmd)
  local f = os.execute(cmd)
  if f == 0 then
    print '\nBuild: ✔️ '
  else
    print('\nBuild: ❌ (code: ' .. f .. ')')
  end
end

vim.g.dotnet_get_dll_path = function()
  local request = function()
    return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
  end

  if vim.g['dotnet_last_dll_path'] == nil then
    vim.g['dotnet_last_dll_path'] = request()
  else
    if vim.fn.confirm('Do you want to change the path to dll?\n' .. vim.g['dotnet_last_dll_path'], '&yes\n&no', 2) == 1 then
      vim.g['dotnet_last_dll_path'] = request()
    end
  end

  return vim.g['dotnet_last_dll_path']
end

local config = {
  {
    type = 'coreclr',
    name = 'launch - netcoredbg',
    request = 'launch',
    program = function()
      if vim.fn.confirm('Should I recompile first?', '&yes\n&no', 2) == 1 then
        vim.g.dotnet_build_project()
      end
      return vim.g.dotnet_get_dll_path()
    end,
  },
}

dap.configurations.cs = config
dap.configurations.fsharp = config

local vscode = require 'dap.ext.vscode'
local json = require 'plenary.json'

vscode.json_decode = function(str)
  return vim.json.decode(json.json_strip_comments(str, {}))
end

require('which-key').register { ['<leader>d'] = { name = '+debug' } }

local keymap = vim.keymap
keymap.set('n', '<leader>dB', function()
  require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'Breakpoint Condition' })

keymap.set('n', '<leader>db', require('dap').toggle_breakpoint, { desc = 'Toggle Breakpoint' })

keymap.set('n', '<leader>dc', require('dap').continue, { desc = 'Continue' })

-- keymap.set('n', "<leader>da", function() require("dap").continue({ before = get_args }) end, {desc = "Run with Args" })
keymap.set('n', '<leader>dC', require('dap').run_to_cursor, { desc = 'Run to Cursor' })

keymap.set('n', '<leader>dg', function()
  require('dap').goto_()
end, { desc = 'Go to Line (No Execute)' })

keymap.set('n', '<leader>di', function()
  require('dap').step_into()
end, { desc = 'Step Into' })

keymap.set('n', '<leader>dj', function()
  require('dap').down()
end, { desc = 'Down' })

keymap.set('n', '<leader>dk', function()
  require('dap').up()
end, { desc = 'Up' })

keymap.set('n', '<leader>dl', function()
  require('dap').run_last()
end, { desc = 'Run Last' })

keymap.set('n', '<leader>do', function()
  require('dap').step_out()
end, { desc = 'Step Out' })

keymap.set('n', '<leader>dO', function()
  require('dap').step_over()
end, { desc = 'Step Over' })

keymap.set('n', '<leader>dp', function()
  require('dap').pause()
end, { desc = 'Pause' })

keymap.set('n', '<leader>dr', function()
  require('dap').repl.toggle()
end, { desc = 'Toggle REPL' })

keymap.set('n', '<leader>ds', function()
  require('dap').session()
end, { desc = 'Session' })

keymap.set('n', '<leader>dt', function()
  require('dap').terminate()
end, { desc = 'Terminate' })

keymap.set('n', '<leader>dw', function()
  require('dap.ui.widgets').hover()
end, { desc = 'Widgets' })

keymap.set('n', '<leader>du', function()
  require('dapui').toggle {}
end, { desc = 'Dap UI' })

keymap.set({ 'n', 'v' }, '<leader>de', function()
  require('dapui').eval()
end, { desc = 'Eval' })
