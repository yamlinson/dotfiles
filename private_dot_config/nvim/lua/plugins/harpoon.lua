return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon.setup()

		-- Telescope integration
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				})
				:find()
		end

		local keymap = vim.keymap

		-- Open Harpoon
		keymap.set("n", "<leader>he", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)
		keymap.set("n", "<leader>ht", function()
			toggle_telescope(harpoon:list())
		end, { desc = "Open Harpoon via Telescope" })

		-- Manage list
		keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
		end, { desc = "Add current buffer to Harpoon" })
		keymap.set("n", "<leader>hh", function()
			harpoon:list():select(1)
		end, { desc = "Select Harpoon buffer 1" })
		keymap.set("n", "<leader>hda", function()
			harpoon:list():clear()
		end, { desc = "Clear all Harpoon buffers" })
		keymap.set("n", "<leader>hdh", function()
			harpoon:list():removeAt(1)
		end, { desc = "Remove Harpoon buffer 1" })
		keymap.set("n", "<leader>hdj", function()
			harpoon:list():removeAt(2)
		end, { desc = "Remove Harpoon buffer 2" })
		keymap.set("n", "<leader>hdk", function()
			harpoon:list():removeAt(3)
		end, { desc = "Remove Harpoon buffer 3" })
		keymap.set("n", "<leader>hdl", function()
			harpoon:list():removeAt(4)
		end, { desc = "Remove Harpoon buffer 4" })

		-- Select buffers
		keymap.set("n", "<leader>hj", function()
			harpoon:list():select(2)
		end, { desc = "Select Harpoon buffer 2" })
		keymap.set("n", "<leader>hk", function()
			harpoon:list():select(3)
		end, { desc = "Select Harpoon buffer 3" })
		keymap.set("n", "<leader>hl", function()
			harpoon:list():select(4)
		end, { desc = "Select Harpoon buffer 4" })
		keymap.set("n", "<leader>hN", function()
			harpoon:list():prev()
		end, { desc = "Select previous Harpoon buffer" })
		keymap.set("n", "<leader>hn", function()
			harpoon:list():next()
		end, { desc = "Select next Harpoon buffer" })
	end,
}
