vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- visual cues
opt.relativenumber = true
opt.number = true
opt.cursorline = true
opt.wrap = false
opt.incsearch = true
opt.scrolloff = 8
opt.colorcolumn = "120"

-- tabs & indents
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- search
opt.ignorecase = true
opt.smartcase = true

-- substitute
opt.gdefault = true

-- colors
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- window splits
opt.splitright = true
opt.splitbelow = true
