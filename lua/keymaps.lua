vim.g.mapleader = " "

local nvim_config_dir = vim.fn.expand("~/.config/nvim")

vim.keymap.set("n", "<leader>o", function()
  local buf_path = vim.fn.expand("%:p") -- absolute path of current buffer

  if vim.startswith(buf_path, nvim_config_dir) then
    vim.cmd("update")
    vim.cmd("source %")
    print("Reloaded config ✅")
  else
    print("Not a nvim config file, skipping reload ❌")
  end
end, { desc = "Update + source only in nvim config" })

vim.keymap.set("i", "<CR>", function()
  return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
end, { expr = true, noremap = true })

