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
				"emmet-language-server",
				"gopls",
				"html",
				"intelephense",
				"jdtls",
				"jinja_lsp",
				"kotlin_language_server",
				"lua_ls",
				"marksman",
				"pyright",
				"ruby-lsp",
				"solargraph",
				"terraformls",
				"vuels",
				"yamlls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"ansible-lint",
				"black",
				"checkstyle",
				"erb-formatter",
				"erb-lint",
				"eslint_d",
				"gofumpt",
				"google-java-format",
				"isort",
				"ktfmt",
				"ktlint",
				"phpmd",
				"prettier",
				"pretty-php",
				"pylint",
				"revive",
				"rubyfmt",
				"shellharden",
				"stylua",
				"tflint",
			},
		})
	end,
}
