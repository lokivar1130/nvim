vim.lsp.config("marksman", {
  cmd = { 'marksman', 'server' },
  filetypes = { 'markdown', 'makrdown.mdx' },
  root_markers = {".marksman.toml",".git"}

})
