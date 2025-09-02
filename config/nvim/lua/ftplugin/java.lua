local jdtls = require('jdtls')

local root_dir = vim.fs.dirname(vim.fs.find({'.git', 'mvnw', 'gradlew'}, {upward = true})[1])

local config = {
  cmd = {'jdtls'},
  root_dir = root_dir,
}

jdtls.start_or_attach(config)
