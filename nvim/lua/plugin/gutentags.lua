return {
  "ludovicchabant/vim-gutentags",
  init = function()
    vim.g.gutentags_enabled = 1

    local ctags_bin = vim.fn.exepath("ctags")
    vim.g.gutentags_ctags_executable = (ctags_bin ~= "" and ctags_bin) or "ctags"

    -- Keep tags file in project root (old Vim workflow).
    vim.g.gutentags_cache_dir = ""
    vim.g.gutentags_ctags_tagfile = "tags"
    vim.g.gutentags_ctags_auto_set_tags = 1

    vim.g.gutentags_generate_on_write = 1
    vim.g.gutentags_generate_on_missing = 1
    vim.g.gutentags_generate_on_new_file = 1
  end,
}
