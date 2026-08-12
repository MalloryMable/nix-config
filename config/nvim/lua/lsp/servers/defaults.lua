local M = {}
local config = require('config')
local u = require('utils')
local lsp_mappings = require('lsp.mappings')

function M.on_attach(client, bufnr)
  local function buf_set_option(name, value)
    vim.api.nvim_set_option_value(name, value, {
      buf = bufnr,
    })
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  if config.lsp.inlay_hint and client.supports_method('textDocument/inlayHint') then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  -- set up default mappings
  lsp_mappings.init(client, bufnr)

  -- set up any additional mappings/overrides from user config
  for _, callback in pairs(config.lsp.on_attach_mappings) do
    callback(client, bufnr)
  end
end

M.capabilities = u.merge(require('cmp_nvim_lsp').default_capabilities(), {
  -- See: https://github.com/neovim/neovim/issues/23291
  workspace = {
    didChangeWatchedFiles = {
      dynamicRegistration = false,
    },
  },
})

return M
