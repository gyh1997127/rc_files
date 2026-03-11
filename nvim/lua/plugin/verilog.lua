return {
  "vhda/verilog_systemverilog.vim",
  init = function()
    -- Set filetype to verilog_systemverilog for relevant extensions
    vim.filetype.add({
      extension = {
        sv = "verilog_systemverilog",
        svh = "verilog_systemverilog",
        v = "verilog_systemverilog",
        vh = "verilog_systemverilog",
      },
    })
  end,
  config = function()
  end,
}
