local config = require('config')

return {
  'folke/which-key.nvim',
  config = function()
    local wk = require('which-key')
    wk.setup({
      win = {
        border = config.border,
        --[[ position = 'bottom', ]]
        --[[ margin = { 1, 0, 1, 0 }, ]]
        padding = { 3, 2, 3, 2 },
        --[[ winblend = 20, ]]
      },
      layout = {
        height = { min = 10, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 8,
        align = 'center',
      },
    })

    wk.add({
      { '<leader>c', group = 'quickfix' },
      { '<leader>f', group = 'find' },
      { '<leader>ht', group = 'toggle' },
      { '<leader>k', group = 'buffer' },
      { '<leader>l', group = 'lsp' },
      { '<leader>ld', group = 'diagnostics' },
      { '<leader>lt', group = 'toggle' },
      { '<leader>lw', group = 'workspace' },
      { '<leader>p', group = 'lazy (plugins)' },
      { '<leader>s', group = 'session' },
      { '<leader>t', group = 'tab' },
      { '<leader>v', group = 'git (vsc)' },
      { '<leader>vt', group = 'toggle' },
      { '<leader>x', group = 'trouble' },
    })
  end,
  event = 'VeryLazy',
}
