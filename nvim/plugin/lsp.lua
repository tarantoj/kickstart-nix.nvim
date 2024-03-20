local lspconfig = require 'lspconfig'
local navic = require 'nvim-navic'

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

local capabilities = vim.tbl_deep_extend('keep', vim.lsp.protocol.make_client_capabilities(), require('cmp_nvim_lsp').default_capabilities())

lspconfig.omnisharp.setup {
  on_attach = function(client, bufnr)
    vim.cmd.compiler 'dotnet'
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  cmd = { 'OmniSharp' },
  handlers = {
    -- ['textDocument/definition'] = require('omnisharp_extended').handler,
    ['textDocument/definition'] = require('omnisharp_extended').definition_handler,
    ['textDocument/references'] = require('omnisharp_extended').references_handler,
    ['textDocument/implementation'] = require('omnisharp_extended').implementation_handler,
  },
  -- Enables support for reading code style, naming convention and analyzer
  -- settings from .editorconfig.
  enable_editorconfig_support = true,

  -- If true, MSBuild project system will only load projects for files that
  -- were opened in the editor. This setting is useful for big C# codebases
  -- and allows for faster initialization of code navigation features only
  -- for projects that are relevant to code that is being edited. With this
  -- setting enabled OmniSharp may load fewer projects and may thus display
  -- incomplete reference lists for symbols.
  enable_ms_build_load_projects_on_demand = false,

  -- Enables support for roslyn analyzers, code fixes and rulesets.
  enable_roslyn_analyzers = true,

  -- Specifies whether 'using' directives should be grouped and sorted during
  -- document formatting.
  organize_imports_on_format = true,

  -- Enables support for showing unimported types and unimported extension
  -- methods in completion lists. When committed, the appropriate using
  -- directive will be added at the top of the current file. This option can
  -- have a negative impact on initial completion responsiveness,
  -- particularly for the first few completion sessions after opening a
  -- solution.
  enable_import_completion = true,

  -- Specifies whether to include preview versions of the .NET SDK when
  -- determining which version to use for project loading.
  sdk_include_prereleases = true,

  -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
  -- true
  analyze_open_documents_only = true,
}

lspconfig.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}

lspconfig.yamlls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    yaml = {
      schemaStore = {
        -- You must disable built-in schemaStore support if you want to use
        -- this plugin and its advanced options like `ignore`.
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = '',
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
}

lspconfig.eslint.setup {
  --- ...
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      command = 'EslintFixAll',
    })
    on_attach(client, bufnr)
  end,
}

lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.typos_lsp.setup {

  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global, etc.
        globals = {
          'vim',
          'describe',
          'it',
          'assert',
          'stub',
        },
        disable = {
          'duplicate-set-field',
        },
      },
      workspace = {
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
      hint = { -- inlay hints (supported in Neovim >= 0.10)
        enable = true,
      },
      codeLens = {
        enable = true,
      },
    },
  },
}

lspconfig.nil_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
