return {
  "ludovicchabant/vim-gutentags",
  init = function()
    -- Prevent gutentags from creating a 'tags' file in every subdirectory
    vim.g.gutentags_add_default_project_roots = 0
    vim.g.gutentags_project_root = { ".git", ".slang", "tags" }
    vim.g.gutentags_cache_dir = vim.fn.stdpath("cache") .. "/tags"

    -- Ensure the cache directory exists
    local dir = vim.g.gutentags_cache_dir
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
}
