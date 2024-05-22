require('obsidian').setup {
  workspaces = {
    {
      name = 'personal',
      path = '~/Documents/notes',
    },
  },
  completion = {
    -- Set to false to disable completion.
    nvim_cmp = true,
    -- Trigger completion at 2 chars.
    min_chars = 2,
  },
}
