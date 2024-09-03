return {
	"navarasu/onedark.nvim",
	config = function()
		require("onedark").setup({
			style = "deep",
			transparent = true,
		})
		require("onedark").load()
	end,
}
