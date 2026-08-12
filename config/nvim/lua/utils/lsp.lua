local M = {}

function M.buf_get_active_clients_str()
  local active_clients = vim.lsp.get_clients({
    bufnr = vim.api.nvim_get_current_buf(),
  })
  local client_names = {}

  for _, client in pairs(active_clients or {}) do
    table.insert(client_names, client.name)
  end

  if not vim.tbl_isempty(client_names) then
    table.sort(client_names)
  end

  local client_str = ''

  if #client_names < 1 then
    return
  end

  for i, client_name in ipairs(client_names) do
    client_str = client_str .. client_name
    if i < #client_names then
      client_str = client_str .. ', '
    end
  end

  return client_str
end

function M.toggle_inlay_hints()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }))
end

return M
