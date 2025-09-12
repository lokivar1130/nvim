vim.g.mapleader = " "
local nvim_config_dir = vim.fn.expand("~/.config/nvim")
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')

vim.keymap.set("i", "<CR>", function()
  return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
end, { expr = true, noremap = true })

vim.keymap.set("n", "<leader>nh", function()
  vim.cmd("nohlsearch")
end)
