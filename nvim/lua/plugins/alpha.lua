return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set header
		vim.api.nvim_set_hl(0, "NeovimDashboardLogo1", { fg = "#0080ff" })
		vim.api.nvim_set_hl(0, "NeovimDashboardLogo2", { fg = "#00bfff" })
		vim.api.nvim_set_hl(0, "NeovimDashboardLogo3", { fg = "#00ffff" })
		vim.api.nvim_set_hl(0, "NeovimDashboardLogo4", { fg = "#00ffbf" })
		vim.api.nvim_set_hl(0, "NeovimDashboardLogo5", { fg = "#00ff80" })
		vim.api.nvim_set_hl(0, "NeovimDashboardLogo6", { fg = "#00ff40" })
		vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#edd691" })
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
			dashboard.button("LDR ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
			dashboard.button("LDR ff", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("LDR fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
			dashboard.button("LDR wr", "󰁯  > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
			dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
		}

		-- Footer
		dashboard.section.footer.val = {
			" Chop wood. Carry water. ",
		}
		dashboard.section.footer.opts.hl = "AlphaFooter"

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
