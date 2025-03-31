return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
  config = function()
    require('oil').setup()

    local map = require('utils').set_keymap

    map('n', '-', '<CMD>Oil<cr>', { desc = 'Open parent directory' })
    map('n', '<leader>o', '<CMD>Oil .<cr>', { desc = 'Open current directory' })
  end,
}
