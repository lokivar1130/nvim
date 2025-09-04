require('onedark').setup {
  style = 'deep'
}
vim.cmd("colorscheme onedark")
vim.cmd(":hi statusline guibg=NONE")
vim.opt.termguicolors = true
