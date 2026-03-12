return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = "Telescope",
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files<CR>', desc = "Find Files" },
    { '<leader>fg', '<cmd>Telescope live_grep<CR>', desc = "Grep Search" },
    { '<leader>fb', '<cmd>Telescope buffers<CR>', desc = "List Buffers" },
    { '<leader>fh', '<cmd>Telescope help_tags<CR>', desc = "Help Tags" },
    { '<leader>fs', '<cmd>Telescope lsp_document_symbols<CR>', desc = "Find Symbols in File" },
    { '<leader>fw', '<cmd>Telescope grep_string<CR>', desc = "Search Word under Cursor" },
    { '<leader>fc', '<cmd>Telescope git_commits<CR>', desc = "Search File Git History" },
  },
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
            file_ignore_patterns = { 'node_modules', '.venv', 'tag' },
            no_ignore = true,
            additional_args = function(_)
              return { "--hidden" }
            end
          },
          find_files = {
            file_ignore_patterns = { 'node_modules', '.venv', 'tag' },
            no_ignore = true,
            hidden = true
          }
        },
      })
  end
}
