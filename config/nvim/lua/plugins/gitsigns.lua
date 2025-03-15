local config = require('config')
local u = require('utils')

return {
  'lewis6991/gitsigns.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'VeryLazy',
  config = function()
    local gitsigns = require('gitsigns')
    gitsigns.setup({
      --[[ signs = { ]]
      --[[   add = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' }, ]]
      --[[   change = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' }, ]]
      --[[   delete = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' }, ]]
      --[[   topdelete = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' }, ]]
      --[[   changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' }, ]]
      --[[ }, ]]
      preview_config = {
        -- Options passed to nvim_open_win
        border = config.border,
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
      },
      on_attach = function(bufnr)
        local map = u.create_buf_map(bufnr)
        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gitsigns.nav_hunk('next')
          end)
          return '<Ignore>'
        end, {
          expr = true,
          desc = 'Next git hunk',
        })

        map('n', '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gitsigns.nav_hunk('prev')
          end)
          return '<Ignore>'
        end, {
          expr = true,
          desc = 'Prev git hunk',
        })

        -- Actions
        map('n', '<leader>vs', gitsigns.stage_hunk, { desc = 'Stage hunk' })
        map('n', '<leader>vr', gitsigns.reset_hunk, { desc = 'Reset hunk' })
        map('v', '<leader>vs', function()
          gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, {
          desc = 'Stage hunk selection',
        })
        map('v', '<leader>vr', function()
          gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, {
          desc = 'Reset hunk selection',
        })
        map('n', '<leader>vS', gitsigns.stage_buffer, { desc = 'Stage buffer' })
        map('n', '<leader>vR', gitsigns.reset_buffer, { desc = 'Reset buffer' })
        map('n', '<leader>vp', gitsigns.preview_hunk, { desc = 'Preview hunk' })
        map('n', '<leader>vb', function()
          gitsigns.blame_line({ full = true })
        end, {
          desc = 'Blame line',
        })
        map('n', '<leader>vtb', gitsigns.toggle_current_line_blame, { desc = 'Toggle blame current line' })
        map('n', '<leader>vd', gitsigns.diffthis, { desc = 'Diff buffer' })
        map('n', '<leader>vD', function()
          gitsigns.diffthis('~')
        end, { desc = 'Diff project' })
        map('n', '<leader>td', gitsigns.preview_hunk_inline, { desc = 'Toggle delete' })

        --[[ -- Text object ]]
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select hunk' })
      end,
    })
  end,
}
