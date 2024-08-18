---@param bufnr integer
---@param ... string
---@return string
local function first(bufnr, ...)
  local conform = require('conform')
  for i = 1, select('#', ...) do
    local formatter = select(i, ...)
    if conform.get_formatter_info(formatter, bufnr).available then
      return formatter
    end
  end
  return select(1, ...)
end

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
    css = function(bufnr)
      return { first(bufnr, 'prettierd', 'prettier') }
    end,
    html = function(bufnr)
      return { first(bufnr, 'prettierd', 'prettier') }
    end,
    javascript = function(bufnr)
      return { first(bufnr, 'prettierd', 'prettier') }
    end,
    javascriptreact = function(bufnr)
      return { first(bufnr, 'prettierd', 'prettier') }
    end,
    json = function(bufnr)
      return { first(bufnr, 'prettierd', 'prettier') }
    end,
    nix = { 'alejandra' },
    typescript = function(bufnr)
      return { first(bufnr, 'prettierd', 'prettier') }
    end,
    typescriptreact = function(bufnr)
      return { first(bufnr, 'prettierd', 'prettier') }
    end,
    sh = { 'shfmt' },
    markdown = { 'injected' },
    cs = { 'csharpier' },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = 'fallback',
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
