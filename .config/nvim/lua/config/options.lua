-- ==========================================
-- Basic Neovim Configuration
-- ==========================================

local opt = vim.opt
local cmd = vim.cmd
local fn = vim.fn

-- Encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Tabs & Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line Numbers
opt.number = true
opt.relativenumber = true

-- Cursor
opt.cursorline = true

-- Searching
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true

-- History & Undo
opt.history = 1000
opt.undofile = true

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Backspace behavior
opt.backspace = { "indent", "eol", "start" }

-- UI
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Window Splitting
opt.splitright = true
opt.splitbelow = true

-- cmdheight = 0 (only in Neovim 0.8+)
if fn.has("nvim-0.8") == 1 then
	opt.cmdheight = 0
end

-- ==========================================
-- Visual Enhancements
-- ==========================================

-- Transparent popup menu (disable blend)
opt.pumblend = 0
cmd("highlight Pmenu guibg=NONE") -- fix: 'pumblend' is a number, not a highlight group

-- Undercurl in supported terminals
cmd([[let &t_Cs = "\e[4:3m"]])
cmd([[let &t_Ce = "\e[4:0m"]])

-- Add asterisk when continuing block comment lines
opt.formatoptions:append("r")

-- ==========================================
-- Filetype Specific Settings
-- ==========================================

cmd([[au BufNewFile,BufRead *.astro setfiletype astro]])
cmd([[au BufNewFile,BufRead Podfile setfiletype ruby]])
