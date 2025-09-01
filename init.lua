vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.swapfile = false
vim.g.mapleader = " "
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.cmd("set completeopt+=noselect")
vim.cmd("set completeopt+=menuone")
vim.cmd("set completeopt+=noselect")




-- plugins
vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = 'main' },
	{ src = "https://github.com/mason-org/mason.nvim" },

})



--lsp autocomple
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
		local opts = { buffer = ev.buf, noremap = true, silent = true }

		-- 🚀 Completion
		vim.keymap.set("i", "<leader>lc", "<C-x><C-o>",
			vim.tbl_extend("force", opts, { desc = "LSP completion" }))

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
vim.lsp.config("solidity_ls_nomicfoundation",
	{
		cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
		filetypes = { "solidity" },
		root_markers = { "hardhat.config.js", "hardhat.config.ts", "foundry.toml", "remappings.txt", "truffle.js", "truffle-config.js", "ape-config.yaml", ".git", "package.json" },
		single_file_support = true
	})


--lsp enablement
vim.lsp.enable({ "lua_ls", "solidity_ls_nomicfoundation" })


--plugins config

--mini
require "mini.pick".setup()
vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")

--oil
require "oil".setup()
vim.keymap.set('n', '<leader>e', ":Oil<CR>")

vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

--treesitter

