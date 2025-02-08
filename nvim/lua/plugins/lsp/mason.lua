return {
	"williamboman/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup()

		mason_lspconfig.setup({
			ensure_installed = {
				"ansiblels",
				"bashls",
				"cssls",
				"dockerls",
				"gopls",
				"html",
				"intelephense",
				"jdtls",
				"jinja_lsp",
				"kotlin_language_server",
				"lua_ls",
				"marksman",
				"pyright",
				"terraformls",
				"vuels",
				"yamlls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"ansible-lint",
				"shellharden",
				"black",
				"checkstyle",
				"eslint_d",
				"gofumpt",
				"revive",
				"google-java-format",
				"isort",
				"ktfmt",
				"ktlint",
				"phpmd",
				"prettier",
				"pretty-php",
				"pylint",
				"stylua",
				"tflint",
			},
		})
	end,
}
