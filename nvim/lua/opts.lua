local opt = vim.opt

-- General
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

-- Appearance
opt.number = true              -- Show line numbers
opt.relativenumber = false     -- Absolute numbers (as per your vimrc)
opt.colorcolumn = "120"        -- That vertical line for 120 chars
opt.termguicolors = true       -- Better colors
opt.cursorline = true          -- Highlight current line
opt.signcolumn = "yes"         -- Always show the side column (prevents jumping)

-- Tabs & Indentation
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true           -- Use spaces instead of tabs
opt.autoindent = true
opt.breakindent = true         -- Wrapped lines keep indentation

-- Search
opt.ignorecase = true          -- 'ic'
opt.smartcase = true           -- Don't ignore case if search has caps
opt.hlsearch = true
opt.incsearch = true

-- Behavior
opt.splitright = true          -- Vertical splits go to the right
opt.undofile = true            -- Persistent undo
opt.swapfile = false           -- 'noswapfile'
opt.backup = false             -- 'nobackup'
opt.mouse = "a"                -- Enable mouse support
opt.scrolloff = 8              -- Keep lines visible when scrolling

-- Fold settings
opt.foldnestmax = 3

-- For your 'jj' Esc delay (ttimeoutlen)
vim.o.ttimeoutlen = 100
