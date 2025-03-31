return {
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = {
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
