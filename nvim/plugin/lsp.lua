local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    require('nvim-navic').attach(client, bufnr)
  end
  if vim.lsp.codelens then
    if client.supports_method('textDocument/codeLens') then
      vim.lsp.codelens.refresh { bufnr = bufnr }
      --- autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
      vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave' }, {
        buffer = bufnr,
        callback = function()
          vim.lsp.codelens.refresh { bufnr = bufnr }
        end,
      })
    end
  end
end

local capabilities = vim.tbl_deep_extend(
  'keep',
  vim.lsp.protocol.make_client_capabilities(),
  require('cmp_nvim_lsp').default_capabilities()
)

require('roslyn').setup {
  exe = 'Microsoft.CodeAnalysis.LanguageServer',
  -- filewatching = true,
  ---@diagnostic disable-next-line: missing-fields
  config = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ['csharp|completion'] = {
        ['dotnet_provide_regex_completions'] = true,
        ['dotnet_show_completion_items_from_unimported_namespaces'] = true,
        ['dotnet_show_name_completion_suggestions'] = true,
      },
      ['csharp|highlighting'] = {
        ['dotnet_highlight_related_json_components'] = true,
        ['dotnet_highlight_related_regex_components'] = true,
      },
      -- ['navigation'] = {
      --   ['dotnet_navigate_to_decompiled_sources'] = true,
      -- },
      ['csharp|inlay_hints'] = {
        csharp_enable_inlay_hints_for_implicit_object_creation = true,
        csharp_enable_inlay_hints_for_implicit_variable_types = true,
        csharp_enable_inlay_hints_for_lambda_parameter_types = true,
        csharp_enable_inlay_hints_for_types = true,
        dotnet_enable_inlay_hints_for_indexer_parameters = true,
        dotnet_enable_inlay_hints_for_literal_parameters = true,
        dotnet_enable_inlay_hints_for_object_creation_parameters = true,
        dotnet_enable_inlay_hints_for_other_parameters = true,
        dotnet_enable_inlay_hints_for_parameters = true,
        dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
        dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
        dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
      },
      ['csharp|code_lens'] = { dotnet_enable_tests_code_lens = false },
      -- ['csharp|background_analysis'] = {
      --   dotnet_analyzer_diagnostics_scope = 'FullSolution',
      --   dotnet_compiler_diagnostics_scope = 'FullSolution',
      -- },
    },
  },
}
-- lspconfig.omnisharp.setup {
--   on_attach = function(client, bufnr)
--     vim.cmd.compiler('dotnet')
--     on_attach(client, bufnr)
--   end,
--   capabilities = capabilities,
--   cmd = { 'OmniSharp' },
--   handlers = {
--     ['textDocument/definition'] = require('omnisharp_extended').definition_handler,
--     ['textDocument/typeDefinition'] = require('omnisharp_extended').type_definition_handler,
--     ['textDocument/references'] = require('omnisharp_extended').references_handler,
--     ['textDocument/implementation'] = require('omnisharp_extended').implementation_handler,
--   },
--   -- Enables support for reading code style, naming convention and analyzer
--   -- settings from .editorconfig.
--   enable_editorconfig_support = true,
--
--   -- If true, MSBuild project system will only load projects for files that
--   -- were opened in the editor. This setting is useful for big C# codebases
--   -- and allows for faster initialization of code navigation features only
--   -- for projects that are relevant to code that is being edited. With this
--   -- setting enabled OmniSharp may load fewer projects and may thus display
--   -- incomplete reference lists for symbols.
--   enable_ms_build_load_projects_on_demand = false,
--
--   -- Enables support for roslyn analyzers, code fixes and rulesets.
--   enable_roslyn_analyzers = true,
--
--   -- Specifies whether 'using' directives should be grouped and sorted during
--   -- document formatting.
--   organize_imports_on_format = true,
--
--   -- Enables support for showing unimported types and unimported extension
--   -- methods in completion lists. When committed, the appropriate using
--   -- directive will be added at the top of the current file. This option can
--   -- have a negative impact on initial completion responsiveness,
--   -- particularly for the first few completion sessions after opening a
--   -- solution.
--   enable_import_completion = true,
--
--   -- Specifies whether to include preview versions of the .NET SDK when
--   -- determining which version to use for project loading.
--   sdk_include_prereleases = true,
--
--   -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
--   -- true
--   analyze_open_documents_only = true,
-- }

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
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      command = 'EslintFixAll',
    })
    on_attach(client, bufnr)
  end,
}

lspconfig.ts_ls.setup {
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

lspconfig.nixd.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.bashls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.clangd.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.lemminx.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.dockerls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.docker_compose_language_service.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
