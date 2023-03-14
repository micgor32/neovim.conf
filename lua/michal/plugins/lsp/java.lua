local home = os.getenv("HOME")
local jdtls = require("jdtls")
local root_markers = { "gradlew", "mvnw", ".git" }
local root_dir = require("jdtls.setup").find_root(root_markers)
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

--local remap = require("me.util").remap

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	jdtls.setup_dap({ hotcodereplace = "auto" })
	jdtls.setup.add_commands()

	-- Default keymaps
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	require("lsp.defaults").on_attach(client, bufnr)

	-- Java extensions
	remap("n", "<C-o>", jdtls.organize_imports, bufopts, "Organize imports")
	--remap("n", "<leader>tt", jdtls.test_class, bufopts, "Test class (DAP)")
	--remap("n", "<leader>tm", jdtls.test_nearest_method, bufopts, "Test method (DAP)")
	remap("n", "<space>ev", jdtls.extract_variable, bufopts, "Extract variable")
	remap("n", "<space>ec", jdtls.extract_constant, bufopts, "Extract constant")
	remap("v", "<space>em", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], bufopts, "Extract method")
end

local bundles = {
	vim.fn.glob(
		home .. "/.vscode/extensions/vscjava.vscode-java-debug-0.49.0/server/com.microsoft.java.debug.plugin-*.jar"
	),
}
vim.list_extend(
	bundles,
	vim.split(vim.fn.glob(home .. "/.local/share/nvim/mason/packages/java-test/extension/server/*.jar"), "\n")
)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local config = {
	flags = {
		debounce_text_changes = 80,
	},
	capabilities = capabilities,
	on_attach = on_attach,
	init_options = {
		bundles = bundles,
	},
	root_dir = root_dir,
	settings = {
		java = {
			format = {
				settings = {
					url = "/.local/share/eclipse/eclipse-java-google-style.xml",
					profile = "GoogleStyle",
				},
			},
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" },
			completion = {
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
				filteredTypes = {
					"com.sun.*",
					"io.micrometer.shaded.*",
					"java.awt.*",
					"jdk.*",
					"sun.*",
				},
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
				hashCodeEquals = {
					useJava7Objects = true,
				},
				useBlocks = true,
			},
			configuration = {
				runtimes = {
					{
						name = "JavaSE-11",
						path = "/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home",
					},
					{
						name = "JavaSE-17",
						path = "/Library/Java/JavaVirtualMachines/jdk-17.0.6.jdk/Contents/Home",
					},
				},
			},
		},
	},
	cmd = {
		"/usr/bin/java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx4g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
		"-jar",
		vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		home .. "/.local/share/nvim/mason/packages/jdtls/config_mac",
		"-data",
		workspace_folder,
	},
}

local M = {}
function M.make_jdtls_config()
	return config
end
return M
