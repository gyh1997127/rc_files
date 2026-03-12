local api = vim.api

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
