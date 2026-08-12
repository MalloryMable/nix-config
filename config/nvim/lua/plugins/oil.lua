return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = { "echasnovski/mini.icons", opts = {} },
  config = function()
    require('oil').setup()
    require('mini.icons').setup()
    local map = require('utils').set_keymap

    map('n', '-', '<CMD>Oil<cr>', { desc = 'Open parent directory' })
    map('n', '<leader>o', '<CMD>Oil .<cr>', { desc = 'Open current directory' })
  end,
}
