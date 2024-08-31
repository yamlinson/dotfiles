vim.g.mapleader = " "

local keymap = vim.keymap

-- misc or unsorted...
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("i", "<C-CR>", "<Esc>o", { desc = "Start new line in insert mode" })

-- buffer stuff
keymap.set("x", "<leader>p", '"_dP', { desc = "Paste from buffer without yanking selection" })
keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete to void buffer" })

-- move selection
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection up" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection down" })

-- cursor placement fixes
keymap.set("n", "J", "mzJ`z", { desc = "Append line below, keep cursor position" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down, center cursor" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up, center cursor" })
keymap.set("n", "n", "nzzzv", { desc = "Next search result, center cursor" })
keymap.set("n", "N", "Nzzzv", { desc = "Previous search result, center cursor" })

-- window splits
keymap.set("n", "<leader>sv", "<C-w>s", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>v", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- window movements
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to the left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to the down window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to the up window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to the right window" })

-- tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer new tab" })
