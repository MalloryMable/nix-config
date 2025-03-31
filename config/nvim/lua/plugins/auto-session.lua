return {
  'rmagatti/auto-session',
  lazy = false,
  opts = {
    auto_restore = false,
    pre_save_cmds = { 'cclose', 'lua vim.notify.dismiss()' },
  },
  init = function()
    local map = require('utils').set_keymap

    -- session
    map('n', '<leader>sl', '<cmd>silent SessionRestore<cr>', { desc = 'Restore session' })
    map('n', '<leader>ss', '<cmd>SaveSession<cr>', { desc = 'Save session' })
  end,
}
