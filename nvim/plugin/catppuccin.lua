if vim.g.did_load_catppuccin_plugin then
  return
end
vim.g.did_load_catppuccin_plugin = true

require('catppuccin').setup {}

-- setup must be called before loading
vim.cmd.colorscheme 'catppuccin'
