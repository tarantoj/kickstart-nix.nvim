local prettier_settings = {
  require_cwd = true,

  cwd = require('conform.util').root_file {
    '.prettierrc',
    '.prettierrc.json',
    '.prettierrc.yml',
    '.prettierrc.yaml',
    '.prettierrc.json5',
    '.prettierrc.js',
    '.prettierrc.cjs',
    '.prettierrc.mjs',
    '.prettierrc.toml',
    'prettier.config.js',
    'prettier.config.cjs',
    'prettier.config.mjs',
  },
}

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
    sh = { 'shfmt' },
    markdown = { 'injected' },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
  formatters = {
    prettier = prettier_settings,
    prettierd = prettier_settings,
    -- resharper = {
    --   args = { 'cleanupcode', '$FILENAME' },
    --   command = 'jb',
    --   stdin = false,
    --   cwd = require('conform.util').root_file { '.git', '*.sln' },
    -- },
  },
}
