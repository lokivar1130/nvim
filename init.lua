require("config.lazy")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local ft = args.match
		local ftplugin = string.format(vim.fn.stdpath("config") .. "/after/ftplugin/%s.lua", ft)

		-- If there's no filetype-specific plugin, source default
		if vim.fn.filereadable(ftplugin) == 0 then
			dofile(vim.fn.stdpath("config") .. "/after/ftplugin/default.lua")
		end
	end,
})
--[[
local handle = io.popen("poetry env info -p 2> /dev/null")

if handle then
	local poetry_env = handle:read("*a"):gsub("%s+", "")
	handle:close()
	if poetry_env and poetry_env ~= "" then
		vim.g.python3_host_prog = poetry_env .. "/bin/python"
	end
end
]]
--
