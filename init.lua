require("options")
require("keymaps")
require("plugins")
require("lsp")

--lsp enablement
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

