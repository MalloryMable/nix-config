local M = {}
local augroup_name = 'CosmicNvimLspFormat'
local config = require('config')
local u = require('utils')
local lsp_utils = require('utils.lsp')
local lsp_mappings = require('lsp.mappings')

M.augroup = vim.api.nvim_create_augroup(augroup_name, { clear = true })

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

  if client.supports_method('textDocument/formatting') then
    -- set up :LspFormat for clients that are capable
    vim.cmd(string.format("command! -nargs=? LspFormat lua require('utils.lsp').buf_format(%s, <q-args>)", bufnr))

    -- set up auto format on save
    vim.api.nvim_clear_autocmds({
      group = M.augroup,
      buffer = bufnr,
    })
    vim.api.nvim_create_autocmd('BufWritePre', {
      callback = function()
        if lsp_utils.format_on_save_enabled then
          vim.lsp.buf.format({
            timeout_ms = config.lsp.format_timeout,
            bufnr = bufnr,
            filter = function(cl)
              return lsp_utils.can_client_format_on_save(cl)
            end,
          })
        end
      end,
      buffer = bufnr,
      group = M.augroup,
    })
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
