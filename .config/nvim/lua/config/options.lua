-- pumblend color transparent for config
vim.cmd("set pumblend=0")
vim.cmd("highlight pumblend guibg=NONE")

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])
vim.cmd([[au BufNewFile,BufRead Podfile setf ruby]])

if vim.fn.has("nvim-0.8") == 1 then
	vim.opt.cmdheight = 0
end

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
opt.relativenumber = true

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
