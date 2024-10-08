-- basics stolen from @diegotty
return {
	"goolord/alpha-nvim",
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		local lazy = require("lazy")
		local dashboard = require("alpha.themes.dashboard")

		require("alpha").setup({
			layout = {
				{ type = "padding", val = 1 },
				{
					type = "text",
					opts = {
						position = "center",
						hl = "DashboardHeader",
					},
					val = {
						[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
						[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
						[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
						[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⠛⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
						[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⠇⠀⠹⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
						[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⡟⠀⡀⠀⢻⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
						[[⠀⠀⠀⠀⢀⣀⣀⣀⣀⣀⣀⣠⣼⣿⣿⠁⢠⣿⡄⠈⣿⣿⣧⣄⣀⣀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀]],
						[[⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⣼⣿⣧⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠁]],
						[[⠀⠀⠙⢿⣿⣷⣄⡀⠀⠤⣤⣤⣤⣤⣤⣴⣿⣿⣿⣦⣤⣤⣤⣤⣤⠤⠀⢀⣠⣾⣿⡿⠋⠀⠀⠀]],
						[[⠀⠀⠀⠀⠈⠻⣿⣿⣶⣄⠀⠙⠻⢿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠋⠀⣠⣴⣿⣿⠟⠁⠀⠀⠀⠀⠀]],
						[[⠀⠀⠀⠀⠀⠀⠈⠙⢿⣿⣿⣦⠀⠀⣾⣿⣿⣿⣿⣿⣷⠀⠀⣴⣾⣿⡿⠛⠁⠀⠀⠀⠀⠀⠀⠀]],
						[[⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⡇⠀⣸⣿⡿⠋⠀⠙⢿⣿⣇⠀⢸⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
						[[⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⠀⢠⠟⠉⢀⣠⣶⣄⠀⠈⠻⡄⠈⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
						[[⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⡇⠀⠀⢀⣴⣿⣿⣿⣿⣿⣦⡀⠀⠀⢸⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀]],
						[[⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⢀⣠⣾⣿⣿⠟⠋⠀⠉⠻⣿⣿⣷⣄⡀⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀]],
						[[⠀⠀⠀⠀⠀⠀⠀⣿⣿⣷⣿⣿⠟⠋⠀⠀⠀⠀⠀⠀⠀⠙⠻⣿⣿⣾⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀]],
						[[⠀⠀⠀⠀⠀⠀⢸⣿⣿⡿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀]],
						[[⠀⠀⠀⠀⠀⠀⡿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⢿⡀⠀⠀⠀⠀⠀⠀]],
						[[⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
					},
				},
				{ type = "padding", val = 1 },
				{
					type = "text",
					val = "lo fanno",
					opts = {
						position = "center",
					},
				},
				{ type = "padding", val = 1 },
				{
					type = "group",
					val = {
						dashboard.button("r", "  recently used files", ":Telescope oldfiles <CR>"),
						dashboard.button("f", "󰈞  find file", ":Telescope find_files <CR>"),
						dashboard.button("n", "  new file", ":ene <BAR> startinsert <CR>"),
						dashboard.button(
							"c",
							"  neovim configuration",
							":cd ~/.config/nvim | :e init.lua | Neotree filesystem reveal left<CR>"
						),
						dashboard.button("z", "  zsh configuration", ":e ~/.zshrc<CR>"),
						dashboard.button("i", "  i3 configuration", ":e ~/.config/i3/config"),
						dashboard.button(
							"b",
							"  i3bar configuration",
							":cd ~/.config/i3blocks | :e config | Neotree filesystem reveal left<CR>"
						),
					},
				},
				{ type = "padding", val = 1 },
				{
					type = "text",
					val = '"someone will remember us / i say / even in another time"',
					opts = {
						position = "center",
						hl = "DashboardFooter",
					},
				},
			},
		})
	end,
}
