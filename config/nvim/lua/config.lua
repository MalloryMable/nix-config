-- lsp server variable
local nvim_lsp = require('lspconfig')

-- -- Enable Swift LSP(source kit)
-- nvim_lsp.sourcekit.setup{}

-- Enable Rust LSP(rust-analyzer)
nvim_lsp.rust_analyzer.setup{}

-- Enable C/C++ LSP (clangd)
nvim_lsp.clangd.setup{
    cmd = { "clangd", "--background-index", "--suggest-missing-includes" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_dir = nvim_lsp.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
    -- Additional configuration options can be set here
}

--  -- Enable Java LSP (nvim-jdtls)
-- nvim_lsp.nvim-jdtls.setup{}

-- Enable auto completiions
local cmp = require'cmp'
cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-v>'] = cmp.mapping.confirm({ select = true }),
      ['<C-e>'] = cmp.mapping.abort(),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    })
})



-- Eanble treesitter
local ts = require("nvim-treesitter")
ts.setup {
  ensure_installed = { "python", "css", "lua", "vim", "json", "toml", "rust", "java", "c" },
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { 'help' }, -- list of language that will be disabled
  },
}
require("nvim-autopairs").setup {}
