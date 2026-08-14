local augroup_name = 'NvimSetup'
local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })

vim.api.nvim_create_autocmd('VimResized', {
  command = 'tabdo wincmd =',
  group = group,
})

vim.api.nvim_create_user_command('CompileLatex', function()
  -- Check if current file is a .tex file
  if vim.fn.expand('%:e') ~= 'tex' then
    vim.notify('Error: Current file is not a .tex file', vim.log.levels.ERROR)
    return
  end

  -- run pdflatex
  -- HACK: Must be run from target directory
  vim.fn.system(string.format('pdflatex "%s"', vim.fn.expand('%:t')))

  local exit_code = vim.v.shell_error
  if exit_code == 0 then
    vim.notify('LaTeX compiled succesfully', vim.log.levels.INFO)
  else
    vim.notify('LaTeX compile failed with exit code: ' .. exit_code, vim.log.levels.ERROR)
  end
end, {
  desc = 'Compiie current LaTeX file with pdflatex'
})

---- Hugo formatting ----

-- Tell Treesitter to use the gotmpl parser for gohtmltmpl files
vim.treesitter.language.register('gotmpl', 'gohtmltmpl')

-- Detect Hugo HTML files as Go templates
vim.filetype.add({
  extension = {
    html = function(path)
      if path:match('layouts') then
        return 'gohtmltmpl'
      end
      return 'html'
    end,
  },
})

-- Fix the comment string for Go templates
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'gohtmltmpl',
  callback = function()
    vim.bo.commentstring = '{{/* %s */}}'
  end,
  group = group,
})

-- "injects" an HTML parser inside of gotmpl files
vim.treesitter.query.set(
  'gotmpl',
  'injections',
  '((text) @injection.content (#set! injection.language "html") (#set! injection.combined))'
)
