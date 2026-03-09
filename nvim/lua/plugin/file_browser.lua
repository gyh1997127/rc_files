return {
  "preservim/nerdtree",
  config = function()
    vim.keymap.set("n", "<leader>b", "::NERDTreeToggle<CR>", { desc = "Toggle File Browser" })
  end
}
