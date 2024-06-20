local telescope = require('telescope')
local actions = require('telescope.actions')

local builtin = require('telescope.builtin')
local keymap = vim.keymap

keymap.set('n', '<leader>,', '<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>', { desc = 'Switch Buffer' })
-- keymap.set('n', "<leader>/", LazyVim.telescope("live_grep"), desc = "Grep (Root Dir)" })
keymap.set('n', '<leader>:', '<cmd>Telescope command_history<cr>', { desc = 'Command History' })
-- keymap.set('n', "<leader><space>", LazyVim.telescope("files"), desc = "Find Files (Root Dir)" })
-- find
keymap.set('n', '<leader>fb', '<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>', { desc = 'Buffers' })
-- keymap.set('n', "<leader>fc", LazyVim.telescope.config_files(), desc = "Find Config File" })
keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
keymap.set('n', '<leader>fF', builtin.git_files, { desc = 'Find Files (git)' })
keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Find Files (git-files)' })
keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', { desc = 'Recent' })
-- keymap.set('n', "<leader>fR", LazyVim.telescope("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" })
-- git
keymap.set('n', '<leader>gc', '<cmd>Telescope git_commits<CR>', { desc = 'Commits' })
keymap.set('n', '<leader>gs', '<cmd>Telescope git_status<CR>', { desc = 'Status' })
-- search
keymap.set('n', '<leader>s"', '<cmd>Telescope registers<cr>', { desc = 'Registers' })
keymap.set('n', '<leader>sa', '<cmd>Telescope autocommands<cr>', { desc = 'Auto Commands' })
keymap.set('n', '<leader>sb', '<cmd>Telescope current_buffer_fuzzy_find<cr>', { desc = 'Buffer' })
keymap.set('n', '<leader>sc', '<cmd>Telescope command_history<cr>', { desc = 'Command History' })
keymap.set('n', '<leader>sC', '<cmd>Telescope commands<cr>', { desc = 'Commands' })
keymap.set('n', '<leader>sd', '<cmd>Telescope diagnostics bufnr=0<cr>', { desc = 'Document Diagnostics' })
keymap.set('n', '<leader>sD', '<cmd>Telescope diagnostics<cr>', { desc = 'Workspace Diagnostics' })
-- keymap.set('n', "<leader>sg", LazyVim.telescope("live_grep"), desc = "Grep (Root Dir)" })
-- keymap.set('n', "<leader>sG", LazyVim.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" })
keymap.set('n', '<leader>sh', '<cmd>Telescope help_tags<cr>', { desc = 'Help Pages' })
keymap.set('n', '<leader>sH', '<cmd>Telescope highlights<cr>', { desc = 'Search Highlight Groups' })
keymap.set('n', '<leader>sk', '<cmd>Telescope keymaps<cr>', { desc = 'Key Maps' })
keymap.set('n', '<leader>sM', '<cmd>Telescope man_pages<cr>', { desc = 'Man Pages' })
keymap.set('n', '<leader>sm', '<cmd>Telescope marks<cr>', { desc = 'Jump to Mark' })
keymap.set('n', '<leader>so', '<cmd>Telescope vim_options<cr>', { desc = 'Options' })
keymap.set('n', '<leader>sR', '<cmd>Telescope resume<cr>', { desc = 'Resume' })
-- keymap.set('n', "<leader>sw", LazyVim.telescope("grep_string", { word_match = "-w" }), desc = "Word (Root Dir)" })
-- keymap.set('n', "<leader>sW", LazyVim.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" })
-- keymap.set('n', "<leader>sw", LazyVim.telescope("grep_string"), mode = "v", desc = "Selection (Root Dir)" })
-- keymap.set('n', "<leader>sW", LazyVim.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" })
-- keymap.set('n', "<leader>uC", LazyVim.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with Preview" })
-- keymap.set('n', '<leader>ss', function()
--   require('telescope.builtin').lsp_document_symbols {
--     symbols = require('lazyvim.config').get_kind_filter(),
--   }
-- end, { desc = 'Goto Symbol' })
-- keymap.set('n', '<leader>sS', function()
--   require('telescope.builtin').lsp_dynamic_workspace_symbols {
--     symbols = require('lazyvim.config').get_kind_filter(),
--   }
-- end, { desc = 'Goto Symbol (Workspace)' })

telescope.setup {
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
    ['ui-select'] = { require('telescope.themes').get_dropdown {} },
  },
}

telescope.load_extension('fzy_native')
telescope.load_extension('ui-select')
-- telescope.load_extension('smart_history')
