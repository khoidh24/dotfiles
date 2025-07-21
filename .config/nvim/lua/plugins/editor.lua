return {
	-- Telescope - File Finder
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-ui-select.nvim",
				config = function()
					require("telescope").load_extension("ui-select")
				end,
			},
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			-- Keymaps
			vim.keymap.set("n", "<C-p>", builtin.find_files, {})
			vim.keymap.set("n", "<C-h>", builtin.live_grep, {})

			telescope.setup({
				defaults = {
					file_ignore_patterns = { ".git/", "node_modules" },
				},
				pickers = {
					find_files = {
						hidden = true,
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
		end,
	},

	-- Neo-tree - File Explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim",
		},
		config = function()
			vim.keymap.set("n", "<C-e>", ":Neotree toggle<CR>", { noremap = true, silent = true })
			require("neo-tree").setup({
				popup_border_style = "rounded",
				enable_diagnostics = true,
				event_handlers = {
					{
						event = "file_opened",
						handler = function()
							require("neo-tree.command").execute({ action = "close" })
						end,
					},
				},
				window = {
					width = 24,
					side = "left",
					auto_resize = true,
					background = "#141B24",
					mappings = {
						["/"] = "noop",
						["#"] = "noop",
						["/F"] = "fuzzy_finder",
						["//"] = "fuzzy_finder",
						["/D"] = "fuzzy_finder_directory",
					},
					fuzzy_finder_mappings = {
						["<C-j>"] = "move_cursor_down",
						["<C-k>"] = "move_cursor_up",
					},
				},
				filesystem = {
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
						hide_gitignored = false,
					},
				},
			})
		end,
	},

	-- UI & UX
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					ignore_focus = { "neo-tree" },
					disabled_filetypes = { statusline = { "neo-tree" }, winbar = {} },
					globalstatus = false,
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = {
						{
							"filename",
							symbols = {
								modified = "",
								readonly = "",
								unnamed = "󰎜 NaN",
								new = "󰎜",
							},
						},
					},
					lualine_x = {
						"encoding",
						"fileformat",
						{ "filetype", colored = true, icon = { align = "left" } },
					},
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},

	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
			{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
		},
		opts = {
			options = {
				mode = "tabs",
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or " "
					return " " .. count .. icon
				end,
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		},
	},

	-- Coding tools
	{ "numToStr/Comment.nvim", lazy = false, opts = {} },
	{ "kylechui/nvim-surround", version = "*", event = "VeryLazy", config = true },
	{ "mg979/vim-visual-multi" },

	-- Notify
	{
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
			require("notify").setup({
				stages = "slide",
				timeout = 3000,
				background_colour = "#000000",
			})
		end,
	},

	-- Git UI
	{
		"kdheepak/lazygit.nvim",
		keys = {
			{ ";c", ":LazyGit<Return>", silent = true, noremap = true },
		},
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- Indent guides
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup({ scope = { enabled = true } })
		end,
	},

	-- Autopairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")
			local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }

			npairs.setup({ check_ts = true, ts_config = { jsx = { "javascript" }, tsx = { "typescript" } } })
			npairs.add_rules({
				Rule(" ", " "):with_pair(function(opts)
					local pair = opts.line:sub(opts.col - 1, opts.col)
					return vim.tbl_contains({ "()", "[]", "{}" }, pair)
				end),
			})
			for _, punct in pairs({ ",", ";" }) do
				npairs.add_rules({
					Rule("", punct)
						:with_move(function(opts)
							return opts.char == punct
						end)
						:with_pair(function()
							return false
						end)
						:with_del(function()
							return false
						end)
						:with_cr(function()
							return false
						end)
						:use_key(punct),
				})
			end
		end,
	},

	-- Auto tag for HTML/JSX
	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-ts-autotag").setup({
				filetypes = {
					"html",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"tsx",
				},
			})
		end,
	},

	-- Git Signs
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				current_line_blame = true,
				current_line_blame_opts = {
					delay = 100,
					virt_text = true,
					virt_text_pos = "eol",
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					local map = function(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					map("n", "<leader>gd", gs.diffthis)
					map("n", "<leader>gb", function()
						gs.blame_line({ full = true })
					end)
					map("n", "[c", gs.prev_hunk)
					map("n", "]c", gs.next_hunk)
				end,
			})
		end,
	},

	-- Notifications & Command Line UI
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {},
	},

	-- Incremental rename
	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup()
			vim.keymap.set("n", "<leader>rn", function()
				return ":IncRename " .. vim.fn.expand("<cword>")
			end, { expr = true, desc = "Rename symbol" })
		end,
	},

	-- Trouble diagnostics
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
		opts = { focus = true },
		cmd = "Trouble",
		keys = {
			{ "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", desc = "Workspace diagnostics" },
			{ "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Document diagnostics" },
			{ "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", desc = "Quickfix list" },
			{ "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "Location list" },
			{ "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "Todo list" },
		},
	},

	-- TODO highlight
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local todo_comments = require("todo-comments")
			todo_comments.setup()
			vim.keymap.set("n", "]t", todo_comments.jump_next, { desc = "Next todo comment" })
			vim.keymap.set("n", "[t", todo_comments.jump_prev, { desc = "Previous todo comment" })
		end,
	},
}
