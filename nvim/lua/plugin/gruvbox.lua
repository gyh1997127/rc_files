return {
  "sainnhe/gruvbox-material",
  priority = 1000,
  config = function()
    vim.g.gruvbox_material_background = "hard"
    vim.o.background = 'light'
    vim.cmd("colorscheme gruvbox-material")
  end
}
