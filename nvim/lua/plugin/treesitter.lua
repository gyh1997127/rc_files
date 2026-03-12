return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      ensure_installed = {
        "c",
        "cpp",
        "python",
        "lua",
        "verilog",
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "verilog", "verilog_systemverilog" },
      },
    })
    if vim.treesitter.language and vim.treesitter.language.register then
      vim.treesitter.language.register("verilog", "verilog_systemverilog")
    end
  end,
}
