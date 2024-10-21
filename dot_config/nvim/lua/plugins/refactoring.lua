return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
	cmd = { "Refactor" },
	opts = {},
	keys = {
		{
			"<leader>Re",
			[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
			{ silent = true, expr = false },
			mode = {
				"v",
				"x",
			},
			desc = "Extract Function",
		},
		{
			"<leader>Rf",
			[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
			{ silent = true, expr = false },
			mode = {
				"v",
				"x",
			},
			desc = "Extract Function To File",
		},
		{
			"<leader>Rv",
			[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
			{ silent = true, expr = false },
			mode = {
				"v",
				"x",
			},
			desc = "Extract Variable",
		},
		{
			"<leader>Ri",
			[[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
			{ silent = true, expr = false },
			mode = {
				"n",
				"v",
				"x",
			},
			desc = "Inline Variable",
		},
		{
			"<leader>Rb",
			function()
				require("refactoring").refactor("Extract Block")
			end,
			{ silent = true, expr = false },
			mode = {
				"n",
			},
			desc = "Extract Block",
		},
		{
			"<leader>Rbf",
			function()
				require("refactoring").refactor("Extract Block To File")
			end,
			{ silent = true, expr = false },
			mode = {
				"n",
			},
			desc = "Extract Block To File",
		},
		{
			"<leader>Rr",
			function()
				require("refactoring").select_refactor()
			end,
			{ silent = true, expr = false },
			desc = "Select Refactor",
		},
		{
			"<leader>Rp",
			function()
				require("refactoring").debug.printf({ below = false })
			end,
			mode = { "n" },
			desc = "Debug: Print Function",
		},
		{
			"<leader>Rd",
			function()
				require("refactoring").debug.print_var({ normal = true, below = false })
			end,
			mode = { "n" },
			desc = "Debug: Print Variable",
		},
		{
			"<leader>Rd",
			function()
				require("refactoring").debug.print_var({ below = false })
			end,
			mode = { "v" },
			desc = "Debug: Print Variable",
		},
		{
			"<leader>Rc",
			function()
				require("refactoring").debug.cleanup({})
			end,
			mode = { "n" },
			desc = "Debug: Clean Up",
		},
	},
}
