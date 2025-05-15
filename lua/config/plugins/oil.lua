return {
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
		config = function()
			require("oil").setup({
				view_options = {
					show_hidden = true,
				},
			})
			local actions = require("oil.actions")
			vim.keymap.set("n", "<Tab>", function()
				if vim.bo.filetype == "oil" then
					actions.close.callback()
				else
					vim.cmd("Oil")
				end
			end)
		end,
	},
}
