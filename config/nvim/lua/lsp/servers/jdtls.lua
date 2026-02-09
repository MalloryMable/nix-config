
local data_path = vim.fn.stdpath("data")

return {
  cmd = { "jdtls" },
  settings = {
    java = {
      format = { enabled = true },
      checkstyle = {
        enabled = true,
        configuration = data_path .. "/java-lint/checkstyle.jar",
      },
      spotbugs = {
        enabled = true,
        configuration = data_path .. "/java-lint/spotbugs.jar",
      },
    },
  },
  init_options = {
    bundles = {
      vim.fn.glob(data_path .. "/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"),
    },
  },
}
