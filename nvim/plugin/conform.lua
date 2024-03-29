require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    -- Conform will run multiple formatters sequentially
    -- python = { "isort", "black" },
    -- Use a sub-list to run only the first available formatter
    -- csharp = { 'resharper' },
    css = { { 'prettierd', 'prettier' } },
    html = { { 'prettierd', 'prettier' } },
    javascript = { { 'prettierd', 'prettier' } },
    javascriptreact = { { 'prettierd', 'prettier' } },
    json = { { 'prettierd', 'prettier' } },
    nix = { 'alejandra' },
    typescript = { { 'prettierd', 'prettier' } },
    typescriptreact = { { 'prettierd', 'prettier' } },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
  formatters = {
    -- resharper = {
    --   args = { 'cleanupcode', '$FILENAME' },
    --   command = 'jb',
    --   stdin = false,
    --   cwd = require('conform.util').root_file { '.git', '*.sln' },
    -- },
  },
}
