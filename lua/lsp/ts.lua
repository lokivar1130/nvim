vim.lsp.config("ts_ls", {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_markers = {
    '.git'
  },
  settings = {
    javascript = { checkJs = true },
    typescript = { strict = true },
  },
})
