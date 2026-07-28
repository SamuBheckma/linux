vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

vim.opt.shortmess:append("IAaoOtTfFnx")
vim.opt.cmdheight = 0
vim.v.errmsg = ""
vim.go.shm = "IAaoOtTfFnx"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})

	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Falha ao instalar lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
		}, true, {})
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

pcall(require, "options")

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	change_detection = {
		notify = false,
	},
})vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

vim.opt.shortmess:append("IAaoOtTfFnx")
vim.opt.cmdheight = 0
vim.v.errmsg = ""
vim.go.shm = "IAaoOtTfFnx"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})

	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Falha ao instalar lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
		}, true, {})
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

pcall(require, "options")

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	change_detection = {
		notify = false,
	},
})
