return {
  'hrsh7th/nvim-cmp',
  config = function()
    require('plugins.nvim-cmp.config')
  end,
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    {
      'saadparwaiz1/cmp_luasnip',
    },
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-path',
    {
      'L3MON4D3/LuaSnip',
      config = function()
        local ls = require('luasnip')
        ls.config.set_config({
          history = true,
          -- Update more often, :h events for more info.
          updateevents = 'TextChanged,TextChangedI',
          enable_autosnippets = true,
        })

        -- extend html snippets to react files
        require('luasnip').filetype_extend('javascriptreact', { 'html' })
        require('luasnip').filetype_extend('typescriptreact', { 'html' })

        -- load snippets (friendly-snippets)
        require('luasnip.loaders.from_vscode').lazy_load()
      end,
      dependencies = {
        'rafamadriz/friendly-snippets',
      },
    },
  },
  event = 'InsertEnter',
}
