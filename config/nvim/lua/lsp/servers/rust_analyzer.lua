return {
  settings = {
    ['rust-analyzer'] = {
      check = {
        command = 'clippy'
      },
      cargo = {
        buildScripts = {
          enable = true
        }
      }
    }
  }
}
