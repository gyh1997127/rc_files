local api = vim.api

-- Register HDL filetypes early so any later plugin sees the expected ft.
vim.filetype.add({
  extension = {
    sv = "verilog_systemverilog",
    svh = "verilog_systemverilog",
    sva = "verilog_systemverilog",
    svi = "verilog_systemverilog",
    svp = "verilog_systemverilog",
    v = "verilog_systemverilog",
    vh = "verilog_systemverilog",
  },
})

api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
  desc = "Use 2-space indentation in all buffers",
})

-- Disabled by default to avoid unexpected background jobs on every save.
-- Set `vim.g.enable_slang_autogen = 1` before loading this module to enable it.
if vim.g.enable_slang_autogen == 1 then
  api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*.sv", "*.v", "*.svh", "*.vh" },
    callback = function()
      local script_path = vim.fn.expand("~/generate_slang_config.py")
      if vim.fn.filereadable(script_path) == 1 then
        vim.fn.jobstart({ "python3", script_path })
      end
    end,
    desc = "Auto-run generate_slang_config.py on save",
  })
end
