return {
  'tpope/vim-fugitive',
  cmd = 'Git',
  init = function()
    local u = require('utils')
    local map = u.set_keymap

    map('n', '<leader>vg', ':vert Git<cr>', { desc = 'Git status' })
  end,
}
