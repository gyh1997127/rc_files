local api = vim.api

-- Auto-run generate_slang_config.py on saving SystemVerilog/Verilog files
api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.sv", "*.v", "*.svh", "*.vh" },
  callback = function()
    local script_path = vim.fn.expand("~/generate_slang_config.py")
    
    -- Check if the script exists in the home directory
    if vim.fn.filereadable(script_path) == 1 then
      -- Run the script in the background using jobstart so it doesn't freeze the editor
      vim.fn.jobstart({ "python3", script_path })
    else
      -- Optional fallback: Check if the script exists in the current working directory
      local cwd_script = vim.fn.getcwd() .. "/generate_slang_config.py"
      if vim.fn.filereadable(cwd_script) == 1 then
        vim.fn.jobstart({ "python3", cwd_script })
      end
    end
  end,
  desc = "Auto-run generate_slang_config.py on save",
})
