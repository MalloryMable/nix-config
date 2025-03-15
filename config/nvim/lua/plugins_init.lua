local config = require('config')

require('lazy').setup('plugins', {
  lockfile = vim.fn.stdpath('config') .. '/lazy-lock.json',
  defaults = { lazy = true },
  ui = {
    border = config.border,
    size = { width = 0.7, height = 0.7 },
  },
  install = {
    missing = true,
    colorscheme = { config.colorscheme },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'netrw',
        'netrwPlugin',
        'netrwSettings',
        'netrwFileHandlers',
        'gzip',
        'zip',
        'zipPlugin',
        'tar',
        'tarPlugin',
        'getscript',
        'getscriptPlugin',
        'vimball',
        'vimballPlugin',
        '2html_plugin',
        'logipat',
        'rrhelper',
        'spellfile_plugin',
        'matchit',
      },
    },
  },
})
