local u = require('utils')

return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'gbprod/none-ls-shellcheck.nvim',
  },
  config = function()
    local defaults = require('lsp.servers.defaults')
    local null_ls = require('null-ls')

    local config_opts = {
      sources = {
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.formatting.prettierd.with({
          env = {
            PRETTIERD_LOCAL_PRETTIER_ONLY = 1,
          },
          extra_filetypes = { 'astro' },
        }),
        null_ls.builtins.formatting.stylua,
      },
    }

    null_ls.setup(u.merge(defaults, config_opts))
  end,
  --[[ event = 'BufEnter', ]]
  lazy = false,
}
