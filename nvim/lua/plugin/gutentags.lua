return {
  "ludovicchabant/vim-gutentags",
  init = function()
    -- Enable gutentags
    vim.g.gutentags_enabled = 1

    -- Use your compiled ctags binary
    vim.g.gutentags_ctags_executable = vim.fn.expand("ctags")

    -- Prevent gutentags from creating a 'tags' file in every subdirectory
    vim.g.gutentags_add_default_project_roots = 0
    vim.g.gutentags_project_root = { ".git", ".slang", "tags" }
    vim.g.gutentags_cache_dir = vim.fn.stdpath("cache") .. "/tags"

    -- Trigger updates on save
    vim.g.gutentags_generate_on_write = 1
    vim.g.gutentags_generate_on_missing = 1
    vim.g.gutentags_generate_on_new_file = 1

    -- Ensure the cache directory exists
    local dir = vim.g.gutentags_cache_dir
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
}
