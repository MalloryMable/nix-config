local config = require('config')

return {
  'neovim/nvim-lspconfig',
  config = function()
    local u = require('utils')
    local default_config = require('lsp.servers.defaults')
    local lspconfig = require('lspconfig')

    local start_server = function(server)
      local server_config = default_config

      local ok, cosmic_server_config = pcall(require, 'lsp.servers.' .. server)
      if ok then
        server_config = u.merge(server_config, cosmic_server_config)
      end

      lspconfig[server].setup(server_config)
    end

    for server, _ in pairs(require('lsp.servers')) do
      start_server(server)
    end
  end,
  lazy = false,
}
