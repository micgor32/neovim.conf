local config = require("michal.plugins.lsp.java").make_jdtls_config()
require("jdtls").start_or_attach(config)
