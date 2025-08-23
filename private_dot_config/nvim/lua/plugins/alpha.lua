return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set header
		vim.api.nvim_set_hl(0, "NeovimDashboardLogo1", { fg = "#5e81ac" })
		vim.api.nvim_set_hl(0, "NeovimDashboardLogo2", { fg = "#6785a7" })
		vim.api.nvim_set_hl(0, "NeovimDashboardLogo3", { fg = "#81a1c1" })
		vim.api.nvim_set_hl(0, "NeovimDashboardLogo4", { fg = "#8bc5eb" })
		vim.api.nvim_set_hl(0, "NeovimDashboardLogo5", { fg = "#88c0d0" })
		vim.api.nvim_set_hl(0, "NeovimDashboardLogo6", { fg = "#8fbcbb" })
		vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#a3be8c" })
		dashboard.section.header.type = "group"
		dashboard.section.header.val = {
			{
				type = "text",
				val = "   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
				opts = { hl = "NeovimDashboardLogo1", shrink_margin = false, position = "center" },
			},
			{
				type = "text",
				val = "   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
				opts = { hl = "NeovimDashboardLogo2", shrink_margin = false, position = "center" },
			},
			{
				type = "text",
				val = "   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
				opts = { hl = "NeovimDashboardLogo3", shrink_margin = false, position = "center" },
			},
			{
				type = "text",
				val = "   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
				opts = { hl = "NeovimDashboardLogo4", shrink_margin = false, position = "center" },
			},
			{
				type = "text",
				val = "   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
				opts = { hl = "NeovimDashboardLogo5", shrink_margin = false, position = "center" },
			},
			{
				type = "text",
				val = "   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
				opts = { hl = "NeovimDashboardLogo6", shrink_margin = false, position = "center" },
			},
		}

		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
			dashboard.button("LDR ff", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("LDR fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
			dashboard.button("LDR wr", "󰁯  > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
			dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
		}

		-- Footer
		dashboard.section.footer.val = {
			" Work harder, get smarter. ",
		}
		dashboard.section.footer.opts.hl = "AlphaFooter"

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
