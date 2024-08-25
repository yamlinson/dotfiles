return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			ansible = { "ansible-lint" },
			bash = { "shellharden" },
			java = { "checkstyle" },
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			go = { "revive" },
			kotlin = { "ktlint" },
			php = { "phpmd" },
			python = { "pylint" },
			terraform = { "tflint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
