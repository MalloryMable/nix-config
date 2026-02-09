return {
  { "mfussenegger/nvim-jdtls", ft = "java" },
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui", dependencies = "mfussenegger/nvim-dap" },
  { "theHamsta/nvim-dap-virtual-text", dependencies = "mfussenegger/nvim-dap" },

  {
    "java-debug",
    dir = vim.fn.stdpath("data") .. "/java-debug",
    cond = function()
      local debug_dir = vim.fn.stdpath("data") .. "/java-debug"
      return vim.fn.isdirectory(debug_dir) == 1
    end,
    build = function()
      local debug_dir = vim.fn.stdpath("data") .. "/java-debug"
      if vim.fn.isdirectory(debug_dir) == 0 then
        vim.fn.system({ "git", "clone", "--depth=1", "https://github.com/microsoft/java-debug.git", debug_dir })
      else
        vim.fn.system({ "git", "-C", debug_dir, "pull", "--ff-only" })
      end
      vim.fn.system({ "bash", "-c", "cd " .. debug_dir .. " && ./mvnw clean install" })
    end,
  },

  {
    "checkstyle-spotbugs",
    dir = vim.fn.stdpath("data") .. "/java-lint",
    cond = function()
      local lint_dir = vim.fn.stdpath("data") .. "/java-lint"
      return vim.fn.isdirectory(lint_dir) == 1
    end,
    build = function()
      local lint_dir = vim.fn.stdpath("data") .. "/java-lint"
      if vim.fn.isdirectory(lint_dir) == 0 then
        vim.fn.mkdir(lint_dir, "p")
      end
      local checkstyle_url = "https://github.com/checkstyle/checkstyle/releases/download/checkstyle-10.12.3/checkstyle-10.12.3-all.jar"
      local spotbugs_url = "https://repo1.maven.org/maven2/com/github/spotbugs/spotbugs/4.8.3/spotbugs-4.8.3.jar"
      vim.fn.system({ "curl", "-L", "-o", lint_dir .. "/checkstyle.jar", checkstyle_url })
      vim.fn.system({ "curl", "-L", "-o", lint_dir .. "/spotbugs.jar", spotbugs_url })
    end,
  },
}
