vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.swapfile = false
vim.g.mapleader = " "
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')



-- plugins
vim.pack.add({

	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },

})


--lsp enablement
vim.lsp.enable({ "lua_ls" })

--lsp autocomple
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=noselect")

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
vim.lsp.enable('solidity_ls_nomicfoundation')
vim.lsp.config("solidity_ls_nomicfoundation", {
	cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
	filetypes = { "solidity" },
	root_markers = { "hardhat.config.js", "hardhat.config.ts", "foundry.toml", "remappings.txt", "truffle.js", "truffle-config.js", "ape-config.yaml", ".git", "package.json" },
			
})


--lsp keymaps shared
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

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
