return {
  -- Telescope - Find files and words
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- Keymaps
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader><leader>", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

      -- Ignore node_modules in JS Project when search files
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules" },
        },
      })
    end,
  },

  -- Neotree - File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim",
    },
    config = function()
      -- Keymaps to open
      vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })
      vim.cmd([[
  highlight NeoTreeDirectoryIcon guifg=#90A4C6
  highlight NeoTreeDirectoryName guifg=#049DEE
  highlight NeoTreeRootName guifg=#E98C31
  highlight NeoTreeFileName guifg=#90A4C6
  highlight NeoTreeFileNameOpened guifg=#90A4C6
  highlight NeoTreeGitAdded guifg=#74D046
  highlight NeoTreeGitModified guifg=#F7BC47
  highlight NeoTreeGitUntracked guifg=#29324C
]])

      require("neo-tree").setup({
        event_handlers = {
          {
            event = "file_opened",
            handler = function()
              require("neo-tree.command").execute({ action = "close" })
            end,
          },
        },
        window = {
          width = 22,
          side = "left",
          auto_resize = true,
          background = "#141B24",
        },
        filesystem = {
          filtered_items = {
            visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
            hide_dotfiles = false,
            hide_gitignored = true,
          },
        },
      })
    end,
  },

  -- UI Select - Code Action UI Selectr
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },

  -- Lualine - Statusbar
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          ignore_focus = { "neo-tree" },
          disabled_filetypes = {
            statusline = { "neo-tree" },
            winbar = {},
          },
          globalstatus = false,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            {
              "filename",
              symbols = { modified = "", readonly = "", unnamed = "󰎜 NaN", new = "󰎜" },
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

  -- Bufferline - Buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>",   "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. count .. icon
        end,
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  -- Colorizer for CSS
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },

  -- Indent line
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup()
    end,
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")

      npairs.setup({
        check_ts = true,
        ts_config = {
          jsx = { "javascript", "typescript.tsx" },
          tsx = { "typescript", "typescript.tsx" },
        },
      })

      -- Add spaces between parentheses
      local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
      npairs.add_rules({
        Rule(" ", " "):with_pair(function(opts)
          local pair = opts.line:sub(opts.col - 1, opts.col)
          return vim.tbl_contains({
            brackets[1][1] .. brackets[1][2],
            brackets[2][1] .. brackets[2][2],
            brackets[3][1] .. brackets[3][2],
          }, pair)
        end),
      })

      -- Move past commas and semicolons
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

      -- Add angle brackets specifically for JSX/TSX
      npairs.add_rules({
        Rule("<", ">"):with_pair(function(opts)
          return opts.filetype == "jsx" or opts.filetype == "tsx"
        end),
      })
    end,
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },

  -- Comment
  {
    "numToStr/Comment.nvim",
    opts = {
      -- add any options here
    },
    lazy = false,
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },

  -- Multi select
  {
    "mg979/vim-visual-multi",
  },

  -- Notifications
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

  -- Git UI control
  {
    "kdheepak/lazygit.nvim",
    keys = {
      {
        ";c",
        ":LazyGit<Return>",
        silent = true,
        noremap = true,
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  -- Indent line
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup({
        scope = { enabled = true },
      })
    end,
  },
}
