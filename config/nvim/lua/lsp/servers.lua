return {
  -- For nvim itself
  lua_ls = { -- install
    format_on_save = false,
  },
  -- C, C++, etc
  clangd = true,
  -- Rust
  rust_analyzer = true,
  -- LaTeX
  texlab = true,
  -- Python
  jedi_language_server = true,
  -- Web Dev (node-free)
  biome = {
    format_on_save = false,
  },
  denols = {
    format_on_save = false,
  },
}
