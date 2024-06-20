if vim.g.did_load_plugins_plugin then
  return
end
vim.g.did_load_plugins_plugin = true

-- many plugins annoyingly require a call to a 'setup' function to be loaded,
-- even with default configs

require('nvim-surround').setup()
require('which-key').setup()
require('trouble').setup()
require('octo').setup()
require('todo-comments').setup()
require('treesj').setup()
require('nvim-lightbulb').setup {
  autocmd = { enabled = true },
}
require('dressing')
require('ollama').setup {}
require('easy-dotnet').setup()
