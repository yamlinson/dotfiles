return {
	"voldikss/vim-floaterm",
	keys = {
		{ "<leader>ttc", "<cmd>FloatermNew<CR>", desc = "Start a new Floaterm session" },
		{ "<leader>ttp", "<cmd>FloatermPrev<CR>", desc = "Go to previous Floaterm session" },
		{ "<leader>ttn", "<cmd>FloatermNext<CR>", desc = "Go to next Floaterm session" },
		{ "<leader>ttt", "<cmd>FloatermToggle<CR>", desc = "Toggle Floaterm" },
		{ "<C-\\>", "<C-\\><C-n><cmd>FloatermToggle<CR>", mode = "t" }, -- until I find a reason not to :^)
	},
}
