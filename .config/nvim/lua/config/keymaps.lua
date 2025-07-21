-- ==========================================
-- Key Mappings
-- ==========================================

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Set leader key
vim.g.mapleader = " "

-- =====================
-- General
-- =====================
keymap.set("n", "+", "<C-a>", opts)        -- increment number
keymap.set("n", "-", "<C-x>", opts)        -- decrement number
keymap.set("n", "db", "vb_d", opts)        -- delete word backwards
keymap.set("n", "<C-a>", "gg<S-v>G", opts) -- select all
keymap.set("n", "<C-m>", "<C-i>", opts)    -- move forward in jumplist

-- =====================
-- Tab Management
-- =====================
keymap.set("n", "te", ":tabedit<CR>", opts)      -- new tab
keymap.set("n", "<Tab>", ":tabnext<CR>", opts)   -- next tab
keymap.set("n", "<S-Tab>", ":tabprev<CR>", opts) -- previous tab
keymap.set("n", "tw", ":tabclose<CR>", opts)     -- close tab

-- =====================
-- Window Management
-- =====================
keymap.set("n", "ss", ":split<CR>", opts)  -- horizontal split
keymap.set("n", "sv", ":vsplit<CR>", opts) -- vertical split

-- Move between windows
keymap.set("n", "sh", "<C-w>h", opts)
keymap.set("n", "sk", "<C-w>k", opts)
keymap.set("n", "sj", "<C-w>j", opts)
keymap.set("n", "sl", "<C-w>l", opts)

-- Resize windows
keymap.set("n", "<C-S-h>", "<C-w><", opts)
keymap.set("n", "<C-S-l>", "<C-w>>", opts)
keymap.set("n", "<C-S-k>", "<C-w>+", opts)
keymap.set("n", "<C-S-j>", "<C-w>-", opts)

-- =====================
-- LSP / Diagnostics
-- =====================
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)

-- =====================
-- Save / Quit
-- =====================
keymap.set("n", "<Leader>w", ":w<CR>", opts)  -- save file
keymap.set("n", "<Leader>q", ":q<CR>", opts)  -- quit file
keymap.set("n", "<Leader>Q", ":qa<CR>", opts) -- quit all

-- =====================
-- Undercurl (visual)
-- =====================
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
