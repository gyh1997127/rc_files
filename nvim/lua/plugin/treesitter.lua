return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.config")
    configs.setup({
      ensure_installed = {
        "c",
        "cpp",
        "python",
        "lua",
        "verilog",
        "systemverilog"
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "verilog", "systemverilog" },
      },
    })
    require('nvim-treesitter').install({ 'cpp', 'python', 'systemverilog', 'lua' })
  end,
}
