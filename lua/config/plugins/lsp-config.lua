return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        "pyright",
        "ruff",
        "solidity_ls_nomicfoundation",
        "jsonls",
        "gopls",
        "terraformls",
        "ts_ls",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local utils = require("config.utils.solidity")
      local on_attach = require("cmp_nvim_lsp").on_attach

      capabilities.textDocument.completion.completionItem.snippetSupport = true

      vim.diagnostic.config({
        virtual_text = {
          spacing = 4,
          wrap = true, -- 👈 wrap long messages
        },
        float = {
          border = "rounded",
          source = "always", -- Show which LSP sent the message
          header = "",
          prefix = "",
        },
      })
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { noremap = true, silent = true })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
      lspconfig.gopls.setup({
        capabilities = capabilities,
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            analyses = {
              unusedparams = true, -- Warns about unused parameters
              nilness = true,    -- Detects nil issues
              shadow = true,     -- Detects shadowed variables
              unusedwrite = true, -- Warns about unused writes
            },
            staticcheck = true,  -- Enables Staticcheck (extra linting)
            gofumpt = true,      -- Uses gofumpt for better formatting
            completeUnimported = true, -- Autocomplete unimported packages
            usePlaceholders = true, -- Adds placeholders in function signatures
          },
        },
      })
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
      })
      lspconfig.jsonls.setup({
        capabilities = capabilities,
      })
      lspconfig.solidity_ls_nomicfoundation.setup({
        cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
        filetypes = { "solidity" },
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern("foundry.toml", ".git")(fname)
        end,
        single_file_support = true,
        settings = {
          solidity = {
            includePath = "lib",
            remappings = utils.get_foundry_remappings(),
            compiler = {
              executable = "solc",
              version = "latest",
              settings = {
                optimizer = { enabled = true, runs = 200 },
                outputSelection = {
                  ["*"] = { ["*"] = { "abi", "evm.bytecode", "evm.deployedBytecode" } },
                },
              },
            },
          },
        },
      })
      lspconfig.pyright.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "python" }, -- ✅ Fixed: Changed `filetype` to `filetypes`
        settings = {          -- ✅ Corrected way to disable Organize Imports
          pyright = {
            disableLanguageServices = false,
          },
          python = {
            analysis = {
              autoImportCompletions = true,
              typeCheckingMode = "basic",
              diagnosticMode = "workspace",
              useLibraryCodeForTypes = true,
              disableOrganizeImports = true, -- ✅ Corrected placement
            },
          },
        },
      })

      lspconfig.ts_ls.setup({

        on_attach = on_attach,
        capabilities = capabilities,
        init_options = {
          preferences = {
            disableSuggestions = true,
          },
        },
      })
      lspconfig.ruff.setup({
        init_options = {
          settings = {
            logLevel = "info",
          },
          configuration = {
            lint = {
              unfixable = { "F401" },
              ["extend-select"] = { "TID251" },
              ["flake8-tidy-imports"] = {
                ["banned-api"] = {
                  ["typing.TypedDict"] = {
                    msg = "Use `typing_extensions.TypedDict` instead",
                  },
                },
              },
            },
            format = {
              ["quote-style"] = "single",
            },
          },
        },
      })
      lspconfig.terraformls.setup({
        capabilities = capabilities,
      })
      -- LSP prefixed group
      local function with_desc(desc)
        return vim.tbl_extend("force", { noremap = true, silent = true }, { desc = desc })
      end

      -- Hover & Signature Help
      vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, with_desc("Hover Documentation"))
      vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, with_desc("Signature Help"))

      -- Navigation
      vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, with_desc("Go to Definition"))
      vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, with_desc("Go to Declaration"))
      vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, with_desc("Go to Implementation"))
      vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, with_desc("Find References"))

      -- Code Actions & Rename
      vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, with_desc("Code Action"))
      vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, with_desc("Rename Symbol"))

      -- Formatting
      vim.keymap.set("n", "<leader>lf", function()
        vim.lsp.buf.format({ async = true })
      end, with_desc("Format File"))

      -- Diagnostics
      vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, with_desc("Show Line Diagnostics"))
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, with_desc("Previous Diagnostic"))
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, with_desc("Next Diagnostic"))
      vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, with_desc("Diagnostics to LocList"))

      -- Symbols
      vim.keymap.set("n", "<leader>lds", vim.lsp.buf.document_symbol, with_desc("Document Symbols"))
      vim.keymap.set("n", "<leader>lws", vim.lsp.buf.workspace_symbol, with_desc("Workspace Symbols"))
    end,
  },
}
