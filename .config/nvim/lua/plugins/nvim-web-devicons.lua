return {
	"nvim-tree/nvim-web-devicons",

	require("nvim-web-devicons").setup({
	
        require("nvim-web-devicons").set_icon({
			lua = {
                icon = "",
				color = "#532785",
				name = "lua",
			},
		}),
	}),
}

--note: to see icons, run :NvimWebDeviconsHiTest
