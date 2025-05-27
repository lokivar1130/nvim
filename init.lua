require("config.lazy")

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local ft = args.match
    local ftplugin = string.format(vim.fn.stdpath("config") .. "/after/ftplugin/%s.lua", ft)

    -- If there's no filetype-specific plugin, source default
    if vim.fn.filereadable(ftplugin) == 0 then
      dofile(vim.fn.stdpath("config") .. "/after/ftplugin/default.lua")
    end
  end,
})
local hardmode = true
if hardmode then
  -- Show an error message if a disabled key is pressed
  local msg = [[<cmd>echohl Error | echo "KEY DISABLED" | echohl None<CR>]]

  -- Disable arrow keys in insert mode with a styled message
  vim.api.nvim_set_keymap("i", "<Up>", "<C-o>" .. msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap("i", "<Down>", "<C-o>" .. msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap("i", "<Left>", "<C-o>" .. msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap("i", "<Right>", "<C-o>" .. msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap("i", "<Del>", "<C-o>" .. msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap("i", "<BS>", "<C-o>" .. msg, { noremap = true, silent = false })

  -- Disable arrow keys in normal mode with a styled message
  vim.api.nvim_set_keymap("n", "<Up>", msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap("n", "<Down>", msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap("n", "<Left>", msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap("n", "<Right>", msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap("n", "<BS>", msg, { noremap = true, silent = false })
end

--[[
local handle = io.popen("poetry env info -p 2> /dev/null")

if handle then
	local poetry_env = handle:read("*a"):gsub("%s+", "")
	handle:close()
	if poetry_env and poetry_env ~= "" then
		vim.g.python3_host_prog = poetry_env .. "/bin/python"
	end
end
]]
--
