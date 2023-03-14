require("michal.plugins-setup")
require("michal.core.options")
require("michal.core.keymaps")
require("michal.core.colorscheme")
require("michal.plugins.nvim-tree")
require("michal.plugins.lualine")
require("michal.plugins.nvim-cmp")
require("michal.plugins.lsp.mason")
require("michal.plugins.lsp.lspsaga")
require("michal.plugins.lsp.lspconfig")
require("michal.plugins.lsp.null-ls")
require("michal.plugins.autopairs")
require("michal.plugins.treesitter")
require("lspconfig").jdtls.setup({})
require("lspconfig").jedi_language_server.setup({})
require("lspconfig").bashls.setup({})
require("lspconfig").lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})
