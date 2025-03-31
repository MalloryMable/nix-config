local config = {
  border = 'none',
  colorscheme = 'dracula',
  lsp = {
    inlay_hint = false,
    format_timeout = 500,
    rename_notification = true,
    -- table of callbacks pushed via plugins
    on_attach_mappings = {},
  },
}

function config.lsp.add_on_attach_mapping(callback)
  table.insert(config.lsp.on_attach_mappings, callback)
end

return config
