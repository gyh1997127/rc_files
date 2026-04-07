local api = vim.api
local hdl_filetype = "verilog_systemverilog"
local hdl_patterns = { "*.sv", "*.svh", "*.sva", "*.svi", "*.svp", "*.v", "*.vh" }
local view_group = api.nvim_create_augroup("view_persistence", { clear = true })

-- Register HDL filetypes early so any later plugin sees the expected ft.
vim.filetype.add({
  extension = {
    sv = hdl_filetype,
    svh = hdl_filetype,
    sva = hdl_filetype,
    svi = hdl_filetype,
    svp = hdl_filetype,
    v = hdl_filetype,
    vh = hdl_filetype,
  },
})

local hdl_group = api.nvim_create_augroup("hdl_filetypes", { clear = true })

api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufFilePost" }, {
  group = hdl_group,
  pattern = hdl_patterns,
  callback = function(args)
    if vim.bo[args.buf].filetype ~= hdl_filetype then
      vim.bo[args.buf].filetype = hdl_filetype
    end
  end,
  desc = "Normalize HDL buffers to verilog_systemverilog",
})

api.nvim_create_autocmd("FileType", {
  group = hdl_group,
  pattern = "systemverilog",
  callback = function(args)
    vim.bo[args.buf].filetype = hdl_filetype
  end,
  desc = "Normalize builtin systemverilog to verilog_systemverilog",
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

local function is_file_buffer(buf)
  return vim.bo[buf].buftype == "" and api.nvim_buf_get_name(buf) ~= ""
end

api.nvim_create_autocmd("BufWinLeave", {
  group = view_group,
  pattern = "*",
  callback = function(args)
    if is_file_buffer(args.buf) then
      vim.cmd("silent! mkview")
    end
  end,
  desc = "Persist folds and cursor position for file buffers",
})

api.nvim_create_autocmd("BufWinEnter", {
  group = view_group,
  pattern = "*",
  callback = function(args)
    if is_file_buffer(args.buf) then
      vim.cmd("silent! loadview")
    end
  end,
  desc = "Restore folds and cursor position for file buffers",
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
