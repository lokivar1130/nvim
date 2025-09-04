require("oil").setup({
  default_file_explorer = true,
  float = {
    padding = 2,
    max_width = 80,
    max_height = 20,
    border = "rounded",
    win_options = {
      winblend = 10,
    },
  },
})

-- Toggle Oil in floating mode
local function toggle_oil_float()
  local oil = require("oil")
  if vim.bo.filetype == "oil" then
    vim.cmd("bd") -- close oil buffer
  else
    oil.open_float()
  end
end

vim.keymap.set("n", "<leader>e", toggle_oil_float, { desc = "Toggle Oil (float)" })
-- Close Oil with 'q' when inside an Oil buffer
vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function(event)
    local oil = require("oil")

    -- Close Oil with 'q'
    vim.keymap.set("n", "q", "<cmd>bd<CR>", { buffer = event.buf, desc = "Close Oil" })

    -- Backspace → go to parent dir
    vim.keymap.set("n", "<BS>", oil.open, { buffer = event.buf, desc = "Parent directory" })
    vim.keymap.set("n", "<C-h>", oil.open, { buffer = event.buf, desc = "Parent directory (alt)" })

    -- Enter → open file / child dir
    vim.keymap.set("n", "<CR>", oil.select, { buffer = event.buf, desc = "Select / enter" })
  end,
})
