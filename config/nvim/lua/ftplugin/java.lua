local jdtls = require("jdtls")
local dap = require("dap")
local dapui = require("dapui")

-- Better root directory detection
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", ".project" }
local root_dir = jdtls.setup.find_root(root_markers)

-- Debug: Print the detected root directory
if root_dir then
  print("JDTLS Root dir detected: " .. root_dir)
else
  print("JDTLS: No root directory found!")
  return
end

-- Get the base config
local config = require("lsp.servers.jdtls")
config.root_dir = root_dir

-- Set workspace directory (important for JDTLS)
local workspace_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
config.workspace_dir = vim.fn.stdpath("data") .. "/workspace/" .. workspace_name

-- Add some essential JDTLS settings
config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
  java = {
    configuration = {
      updateBuildConfiguration = "interactive",
    },
    compile = {
      nullAnalysis = {
        mode = "automatic",
      },
    },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
      },
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
  },
})

-- Start JDTLS
jdtls.start_or_attach(config)

-- Setup DAP UI
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

