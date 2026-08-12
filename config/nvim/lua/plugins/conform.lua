return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  config = function()
    require('conform').setup({
      -- Map filetypes to formatters
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Add any other web filetypes you need here
        javascript = { 'biome' },
        typescript = { 'biome' },
        javascriptreact = { 'biome' },
        typescriptreact = { 'biome' },
        css = { 'biome' },
        json = { 'biome' },
        html = { 'djlint' },
        gohtmltmpl = { 'djlint' },
      },
      formatters = {
        djlint = {
          prepend_args = { '--profile=golang' },
        },
      },
      -- Optional: Enable format-on-save
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })
  end,
}
