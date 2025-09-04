--solidity
vim.lsp.config("solidity_ls_nomicfoundation", {
  cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
  filetypes = { "solidity" },
  root_markers = { "hardhat.config.js", "hardhat.config.ts", "foundry.toml", "remappings.txt", "truffle.js", "truffle-config.js", "ape-config.yaml", ".git", "package.json" },
})
