local keymap = vim.keymap

-- Set leader key
vim.g.mapleader = " "

-- General
keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })
keymap.set("n", "<leader><cr>", ":noh<cr>", { desc = "Clear search highlights" })

-- Window Navigation (your C-h,j,k,l)
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")

-- Tab management
keymap.set("n", "<leader>tn", ":tabnew<cr>")
keymap.set("n", "<leader>tc", ":tabclose<cr>")
keymap.set("n", "<leader>to", ":tabonly<cr>")

-- Buffer management
keymap.set("n", "<leader>bd", ":bd<cr>", { desc = "Close buffer" })
keymap.set("n", "<leader>ba", ":%bd!<cr>", { desc = "Close all buffers" })

-- Folding
keymap.set("n", "<leader>zz", "za", { desc = "Toggle fold" })
keymap.set("n", "<leader>zR", "zR", { desc = "Open all folds" })
keymap.set("n", "<leader>zM", "zM", { desc = "Close all folds" })

-- Moving lines (Your Shift+J/K trick)
keymap.set("n", "<S-j>", ":m .+1<CR>==", { desc = "Move line down" })
keymap.set("n", "<S-k>", ":m .-2<CR>==", { desc = "Move line up" })
keymap.set("v", "<S-j>", ":m '>+1<CR>gv=gv")
keymap.set("v", "<S-k>", ":m '<-2<CR>gv=gv")

-- Resize windows
keymap.set("n", "<leader>+", ":vertical resize +10<CR>")
keymap.set("n", "<leader>-", ":vertical resize -10<CR>")

-- F5 to remove trailing whitespace (from your original vimrc)
keymap.set("n", "<F5>", [[:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>]])

-- Open tag in vertical split
keymap.set("n", "<C-]>", "<C-W><C-V><C-]>")
