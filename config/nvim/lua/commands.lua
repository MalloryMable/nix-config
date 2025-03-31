local augroup_name = 'CosmicNvim'
local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })

vim.api.nvim_create_autocmd('VimResized', {
  command = 'tabdo wincmd =',
  group = group,
})

vim.cmd([[
  command! CosmicDisableFormatOnSave lua require('utils.lsp').toggle_format_on_save()
]])
