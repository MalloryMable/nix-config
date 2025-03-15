local config = require('config')
local utils = require('utils')

local plugin_config = {
  border_style = 'single',
}

return {
  'CosmicNvim/cosmic-ui',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('cosmic-ui').setup(plugin_config)

    config.lsp.add_on_attach_mapping(function(client, bufnr)
      local buf_map = utils.create_buf_map(bufnr)

      buf_map('n', '<leader>r', '<cmd>lua require("cosmic-ui").rename()<cr>', { desc = 'Rename' })
      buf_map('n', '<leader>la', '<cmd>lua require("cosmic-ui").code_actions()<cr>', { desc = 'Code Actions' })
      buf_map(
        'v',
        '<leader>la',
        '<cmd>lua require("cosmic-ui").range_code_actions()<cr>',
        { desc = 'Range Code Actions' }
      )
    end)
  end,
  event = 'VeryLazy',
}
