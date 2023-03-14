local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

treesitter.setup({
	highlight = {
		enable = true,
	},
	indent = { enable = true },
	autotag = { enable = true },
	ensure_installed = {
		"java",
		"json",
		"yaml",
		"html",
		"css",
		"markdown",
		"bash",
		"lua",
		"vim",
		"dockerfile",
		"gitignore",
	},
	auto_install = true,
})
