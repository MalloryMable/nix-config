return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },
  config = function()
    require('plugins.telescope.config')

    -- normal mappings
    local u = require('utils')
    local map = u.set_keymap

    map('n', '<leader>ff', ':Telescope find_files<cr>', { desc = 'Find project file' })
    map('n', '<leader>fk', ':Telescope buffers<cr>', { desc = 'Find buffer' })
    map('n', '<leader>fs', ':Telescope live_grep<cr>', { desc = 'Grep string' })
    map('n', '<leader>fw', ':Telescope grep_string<cr>', { desc = 'Grep current word' })

    -- git navigation
    map('n', '<leader>vc', ':Telescope git_commits<cr>', { desc = 'Git commits' })
  end,
  cmd = { 'Telescope' },
}
