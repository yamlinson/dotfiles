return {
	"chrishrb/gx.nvim",
	keys = {
		{ "gx", "<cmd>Browse<CR>", mode = { "n", "x" }, desc = "Open link" },
	},
	cmd = { "Browse" },
	init = function()
		vim.g.netrw_nogx = 1
	end,
	dependencies = { "nvim-lua/plenary.nvim" },
	config = true,
}
