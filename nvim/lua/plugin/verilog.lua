return {
  "vhda/verilog_systemverilog.vim",
  ft = { "verilog", "systemverilog" },
  config = function()
    -- Disable indentation as previously requested
    vim.g.verilog_disable_indent = 1
  end,
}
