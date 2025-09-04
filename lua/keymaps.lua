vim.g.mapleader = " "
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')



--local betterTerm = require('betterTerm')
-- Toggle the first terminal (ID defaults to index_base, which is 0)
--vim.keymap.set({ "n", "t" }, "<C-;>", function() betterTerm.open() end, { desc = "Toggle terminal" })

-- Open a specific terminal
--vim.keymap.set({ "n", "t" }, "<C-/>", function() betterTerm.open(1) end, { desc = "Toggle terminal 1" })

-- Select a terminal to focus
--vim.keymap.set("n", "<leader>tt", betterTerm.select, { desc = "Select terminal" })

-- Rename the current terminal
--vim.keymap.set("n", "<leader>tr", betterTerm.rename, { desc = "Rename terminal" })

-- Toggle the tabs bar
--vim.keymap.set("n", "<leader>tb", betterTerm.toggle_tabs, { desc = "Toggle terminal tabs" })

--lsp helper keybinds
-- Confirm completion with <Tab>
vim.keymap.set("i", "<CR>", function()
  return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
end, { expr = true, noremap = true })

vim.keymap.set('n', '<leader>e', ":Oil<CR>")

