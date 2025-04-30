vim.keymap.set("n", "<leader>dw", ":close<CR>", opts)

local ui = require("utils.ui")
vim.keymap.set("n", "<leader>db", ui.bufremove, { desc = "Delete buffer" })
