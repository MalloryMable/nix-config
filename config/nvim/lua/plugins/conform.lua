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
        javascript = { 'prettierd' },
        typescript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        astro = { 'prettierd' },
      },
      formatters = {
        prettierd = {
          env = {
            PRETTIERD_LOCAL_PRETTIER_ONLY = 1,
          },
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
