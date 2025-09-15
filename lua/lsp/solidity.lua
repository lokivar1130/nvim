Utils= require("lsp.utils")

vim.lsp.config("solidity_ls_nomicfoundation", {
  cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
  root_markers = { "hardhat.config.js", "hardhat.config.ts", "foundry.toml", "remappings.txt", "truffle.js", "truffle-config.js", "ape-config.yaml", ".git", "package.json" },
  single_file_support = true,
  filetypes = { "solidity" },
  settings = {
    solidity = {
      root_dir = Utils.find_root,
      defaultCompiler = "remote",
      enabledAsYouTypeCompilationErrorCheck = true,
      remappings = Utils.get_foundry_remappings(),
    },
  }
})
