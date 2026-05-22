local config = require('config')
local utils = require('utils')

return {
  'stevearc/dressing.nvim',
  event = 'VeryLazy',
  config = function()
    require('dressing').setup({
      input = {
        border = 'single',
      },
      select = {
        backend = { 'telescope' },
      },
    })

    config.lsp.add_on_attach_mapping(function(client, bufnr)
      local buf_map = utils.create_buf_map(bufnr)

      buf_map('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = 'Rename' })
      buf_map('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = 'Code Action' })
      buf_map('v', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = 'Range Code Action' })
    end)
  end,
}
