-- 1. Load your custom keybindings (sets leader key)
require("keymaps")

-- 2. Load your basic editor options
require("opts")

-- 3. Load your autocommands
require("autocmds")

-- 4. Load your custom plugin launcher
require("launch")

-- 4. Register your plugins
spec("gruvbox")
spec("lightline")
spec("telescope")
spec("file_browser")
spec("fugitive")
spec("nerdcommenter")
spec("tabular")
spec("treesitter")
spec("slang-server")
spec("lsp")
spec("cmp")
spec("gutentags")

-- 5. Bootstrap and load plugins
require("plugin.lazy")
