local config = require('config')
local utils = require('utils')
local lsp_utils = require('utils.lsp')
local icons = require('utils.icons')

local custom_sections = {
  branch = { 'b:gitsigns_head', icon = icons.branch },
  diff = {
    'diff',
    source = utils.diff_source(),
    symbols = {
      added = icons.diff_add .. ' ',
      modified = icons.diff_modified .. ' ',
      removed = icons.diff_remove .. ' ',
    },
  },
  shortenedFilePath = {
    'filename',
    path = 0,
    symbols = {
      modified = icons.diff_modified,
    },
  },
  relativeFilePath = {
    'filename',
    path = 1,
    symbols = {
      modified = icons.diff_modified,
    },
  },
}

local plugin_config = {
  options = {
    theme = config.colorscheme,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      {
        'filetype',
        icon_only = true,
        padding = {
          left = 1,
          right = 0,
        },
        separator = '',
      },
      custom_sections.shortenedFilePath,
    },
    lualine_c = {
      custom_sections.diff,
    },
    lualine_x = { 'diagnostics' },
    lualine_y = { lsp_utils.buf_get_active_clients_str },
    lualine_z = { 'location', 'progress' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {
      {
        'filetype',
        icon_only = true,
        padding = {
          left = 1,
          right = 0,
        },
        separator = '',
      },
      custom_sections.shortenedFilePath,
    },
    lualine_c = {
      custom_sections.diff,
    },
    lualine_x = { 'diagnostics' },
    lualine_y = { 'location', 'progress' },
    lualine_z = {},
  },
  winbar = {
    lualine_a = { utils.get_short_cwd },
    lualine_b = { custom_sections.branch },
    lualine_c = { custom_sections.relativeFilePath },
    lualine_x = {
      {
        'macro-recording',
        fmt = utils.show_macro_recording,
      },
      'filetype',
    },
    lualine_y = {},
    lualine_z = {},
  },
  inactive_winbar = {
    lualine_a = { utils.get_short_cwd },
    lualine_b = { custom_sections.branch },
    lualine_c = { custom_sections.relativeFilePath },
    lualine_x = { 'filetype' },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { 'quickfix', 'fugitive', 'nvim-tree' },
}

return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  config = function()
    require('lualine').setup(plugin_config)

    vim.api.nvim_create_autocmd('RecordingEnter', {
      callback = function()
        require('lualine').refresh({
          place = { 'statusline' },
        })
      end,
    })

    vim.api.nvim_create_autocmd('RecordingLeave', {
      callback = function()
        -- This is going to seem really weird!
        -- Instead of just calling refresh we need to wait a moment because of the nature of
        -- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
        -- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
        -- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
        -- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
        local timer = vim.uv.new_timer()
        if timer then
          timer:start(
            50,
            0,
            vim.schedule_wrap(function()
              require('lualine').refresh({
                place = { 'statusline' },
              })
            end)
          )
        end
      end,
    })
  end,
}
