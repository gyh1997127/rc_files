return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = require('telescope.actions').close,
            },
          },
          layout_strategy = 'horizontal',
          layout_config = { height = 0.8, width = 0.9 },
        },
        pickers = {
          live_grep = {
            file_ignore_patterns = { 'node_modules', '.git', '.venv', 'tag' },
            additional_args = function(_)
              return { "--hidden" }
            end
          },
          find_files = {
            file_ignore_patterns = { 'node_modules', '.git', '.venv', 'tag' },
            hidden = true
          }
        },
      })
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find Files" })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Grep Search" })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "List Buffers" })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help Tags" })
    vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = "Find Symbols in File" })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = "Search Word under Cursor" })
    vim.keymap.set('n', '<leader>fc', builtin.git_commits, { desc = "Search File Git History" })
  end
}

