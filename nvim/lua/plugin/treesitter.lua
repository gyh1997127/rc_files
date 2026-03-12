return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter")
    local languages = {
      "c",
      "cpp",
      "python",
      "lua",
      "systemverilog",
    }

    treesitter.setup({})
    treesitter.install(languages)

    if vim.treesitter.language and vim.treesitter.language.register then
      vim.treesitter.language.register("systemverilog", { "verilog", "verilog_systemverilog" })
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "c", "cpp", "python", "lua", "verilog", "verilog_systemverilog" },
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
