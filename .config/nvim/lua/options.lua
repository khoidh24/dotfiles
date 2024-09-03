-- pumblend color transparent for config
vim.cmd("set pumblend=0")
vim.cmd("highlight pumblend guibg=NONE")
vim.cmd("highlight NvimTreeNormal guibg=#141B24")

local opt = vim.opt

-- UTF-8 Encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Tabs
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true

-- Indent
opt.autoindent = true -- copy indent from current line when starting new one
opt.smartindent = true -- smart indenting for C-like languages

-- Line numbers
opt.number = true

-- Cursor line
opt.cursorline = true

-- Search
opt.hlsearch = true -- highlight search results
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitivf

-- History
opt.undofile = true
opt.history = 1000

-- Split
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- Clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- Backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- Terminal GUI
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift
