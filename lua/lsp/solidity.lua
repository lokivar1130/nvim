Utils = require("lsp.utils")

vim.lsp.solidity_ls._nomicfoundation = {
  cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
  root_markers = { "hardhat.config.js", "hardhat.config.ts", "foundry.toml", "remappings.txt", "truffle.js", "truffle-config.js", "ape-config.yaml", ".git", "package.json" },
  single_file_support = true,
  filetypes = { "solidity" },
  }
}

