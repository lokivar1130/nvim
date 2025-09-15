require("lsp.lua-ls")
require("lsp.rust")
require("lsp.solidity")

vim.lsp.enable({ "lua_ls", "solidity_ls_nomicfoundation", "rust_analyzer" })

vim.diagnostic.config({
  virtual_lines = false, -- less noisy
  virtual_text = { spacing = 2, prefix = "●" },
  float = { border = "rounded" },
  signs = true
})


--lsp autocomple
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local opts = { buffer = ev.buf, noremap = true, silent = true }
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      vim.keymap.set('i', '<C-Space>', function()
        vim.lsp.completion.get()
      end)
    end

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_codeAction) then
      vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code Action" }))
    end

    if vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(true, { 0 })
    end
    -- 📖 Hover docs
    vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover,
      vim.tbl_extend("force", opts, { desc = "Hover docs" }))
    -- 📍 Go to definition
    vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition,
      vim.tbl_extend("force", opts, { desc = "Go to definition" }))

    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references,
      vim.tbl_extend("force", opts, { desc = "Find references" }))

    -- 📝 Rename symbol
    vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename,
      vim.tbl_extend("force", opts, { desc = "Rename symbol" }))

    -- ✨ Format
    vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format { async = true } end,
      vim.tbl_extend("force", opts, { desc = "Format buffer" }))

    -- ⚠️ Diagnostics
    vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float,
      vim.tbl_extend("force", opts, { desc = "Show error under cursor" }))
    vim.keymap.set("n", "<leader>lj", vim.diagnostic.goto_next,
      vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
    vim.keymap.set("n", "<leader>lk", vim.diagnostic.goto_prev,
      vim.tbl_extend("force", opts, { desc = "Prev diagnostic" }))
    vim.keymap.set("n", "<leader>lE", vim.diagnostic.setqflist,
      vim.tbl_extend("force", opts, { desc = "All diagnostics (quickfix)" }))
  end,
})
