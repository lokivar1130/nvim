vim.pack.add({
  { src = "https://github.com/navarasu/onedark.nvim" },
  { src = "https://github.com/akinsho/toggleterm.nvim" },
  { src = "https://github.com/saghen/blink.cmp" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/rcarriga/nvim-notify" },
  { src = "https://github.com/folke/noice.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/chomosuke/typst-preview.nvim" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/rcarriga/nvim-notify" },

})
require("config.notify")
require("config.oil")
require("config.noice")
require("config.mason")
require("config.onedark")
require("config.telescope")
require("config.blink")
require("config.toggleterm")
