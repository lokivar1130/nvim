vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.swapfile = false
vim.g.mapleader = " "
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')

vim.diagnostic.config({
	-- Use the default configuration
	virtual_lines = true
	-- Alternatively, customize specific options
	-- virtual_lines = {
	--  -- Only show virtual line diagnostics for the current cursor line
	--  current_line = true,
	-- },
})



-- plugins
vim.pack.add({
	{ src = "https://github.com/navarasu/onedark.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	--	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/CRAG666/betterTerm.nvim" }

})



--lsp autocomple
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
			vim.opt.completeopt = { 'menuone', 'noselect', 'popup' }
			local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, ev.buf, {
				autotrigger = true,
				convert = function(item)
					return { abbr = item.label:gsub("%b()", "") }
				end

			})
			-- 🚀 Completion
			vim.keymap.set('i', '<C-Space>',
				vim.lsp.completion.get, { desc = "Trigger Autocompletion" })
		end
		local opts = { buffer = ev.buf, noremap = true, silent = true }

		-- 📖 Hover docs
		vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover,
			vim.tbl_extend("force", opts, { desc = "Hover docs" }))
		-- 📖 Code Actions 
		vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action,
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

--lsp config
--lua

vim.lsp.config("lua_ls",
	{
		settings = {
			Lua = {
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				}
			}
		}
	})

--solidity
vim.lsp.config("solidity_ls_nomicfoundation", {
	cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
	filetypes = { "solidity" },
	root_markers = { "hardhat.config.js", "hardhat.config.ts", "foundry.toml", "remappings.txt", "truffle.js", "truffle-config.js", "ape-config.yaml", ".git", "package.json" },
})


--rust
vim.lsp.config('rust_analyzer', {
	settings = {
		['rust-analyzer'] = {
			diagnostics = {
				enable = false,
			}
		}
	}
})

--lsp enablement
vim.lsp.enable({ "lua_ls", "solidity_ls_nomicfoundation", "rust_analyzer" })


--plugins config

--mini
require "mini.pick".setup()
vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")

--oil
require "oil".setup()
vim.keymap.set('n', '<leader>e', ":Oil<CR>")
require('onedark').setup {
	style = 'deep'
}
vim.cmd("colorscheme onedark")
vim.cmd(":hi statusline guibg=NONE")
--mason
require "mason".setup()
--better terrm
require("betterTerm").setup({

				size = math.floor(vim.o.columns / 6 )
})
local betterTerm = require('betterTerm')

-- Toggle the first terminal (ID defaults to index_base, which is 0)
vim.keymap.set({"n", "t"}, "<C-;>", function() betterTerm.open() end, { desc = "Toggle terminal" })

-- Open a specific terminal
vim.keymap.set({"n", "t"}, "<C-/>", function() betterTerm.open(1) end, { desc = "Toggle terminal 1" })

-- Select a terminal to focus
vim.keymap.set("n", "<leader>tt", betterTerm.select, { desc = "Select terminal" })

-- Rename the current terminal
vim.keymap.set("n", "<leader>tr", betterTerm.rename, { desc = "Rename terminal" })

-- Toggle the tabs bar
vim.keymap.set("n", "<leader>tb", betterTerm.toggle_tabs, { desc = "Toggle terminal tabs" })

--lsp helper keybinds 
vim.keymap.set("i", "<Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return vim.lsp.completion.confirm()
  else
    return "\t"
  end
end, { expr = true })

