require("toggleterm").setup({
  size = 20,                -- height of the floating terminal
  open_mapping = [[<leader>\]],  -- key to toggle the terminal
  hide_numbers = true,      -- hide line numbers in terminal
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,       -- darker background for terminal
  start_in_insert = true,   -- start terminal in insert mode
  insert_mappings = true,   -- mappings work in insert mode
  terminal_mappings = true, -- allow terminal mode mappings
  direction = "float",      -- floating terminal
  float_opts = {
    border = "rounded",     -- rounded border
    width = 160,
    height = 40,
    winblend = 10,
  },
})
