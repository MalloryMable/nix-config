local defaults = require('lsp.servers.defaults')

return {
  on_attach = function(client, bufnr)
    defaults.on_attach(client, bufnr)
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      command = 'EslintFixAll',
      group = defaults.augroup,
    })
  end,
}
