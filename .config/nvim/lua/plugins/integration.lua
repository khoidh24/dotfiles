return {
	{
		"rest-nvim/rest.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = "http",
		config = function()
			require("rest-nvim").setup({
				result_split_in_place = true, -- mở ngay dưới
				highlight = { enabled = true }, -- bật highlight
				result = {
					split = "right", -- Hiển thị kết quả ở bên phải
					formatters = {
						json = "jq",
					},
				},
			})
			vim.keymap.set("n", "<leader>rr", "<cmd>Rest run<CR>", { desc = "Run HTTP request" })
			vim.keymap.set("n", "<leader>rl", "<cmd>Rest run last<CR>", { desc = "Run last HTTP request" })
			vim.keymap.set("n", "<leader>rp", "<cmd>Rest run preview<CR>", { desc = "Preview HTTP request" })
		end,
	},
}
