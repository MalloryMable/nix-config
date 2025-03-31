local config = require('config')
return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/popup.nvim',
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

    config.lsp.add_on_attach_mapping(function(_, bufnr)
      local buf_map = u.create_buf_map(bufnr)

      buf_map('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', { desc = 'Go to definition' })
      buf_map('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', { desc = 'Go to implementation' })
      buf_map('n', 'gt', '<cmd>Telescope lsp_type_definitions<cr>', { desc = 'Go to type definition' })
      buf_map('n', 'gr', '<cmd>Telescope lsp_references<cr>', { desc = 'Go to reference' })

      buf_map('n', '<leader>ldb', '<cmd>Telescope diagnostics bufnr=0<cr>', { desc = 'Show buffer diagnostics' })
      buf_map('n', '<leader>ldw', '<cmd>Telescope diagnostics<cr>', { desc = 'Workspace diagnostics' })
    end)
  end,
  cmd = { 'Telescope' },
}
