lvim.builtin.treesitter.ensure_installed = {
	"python",
	"javascript",
	"bash",
	"css",
	"git_config",
	"git_rebase",
	"gitattributes",
	"gitcommit",
	"gitignore",
	"go",
	"graphql",
	"javascript",
	"ini",
	"html",
	"hcl",
	"lua",
	"markdown",
	"vim",
	"yaml",
	"scss",
	"typescript",
}

lvim.builtin.treesitter.rainbow = {
	enable = true,
	query = {
		"rainbow-parens",
	},
	strategy = require("ts-rainbow").strategy.global,
	hlgroups = {
		-- "TSRainbowRed",
		"TSRainbowBlue",
		-- "TSRainbowOrange",
		-- "TSRainbowCoral",
		"TSRainbowPink",
		"TSRainbowYellow",
		-- "TSRainbowViolet",
		-- "TSRainbowGreen",
	},
}

lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.auto_install = false
