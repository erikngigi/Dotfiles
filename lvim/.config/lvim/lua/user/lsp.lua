local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	-- { name = "black", extra_args = { "--fast" } },
	{ name = "ruff" },
	{ name = "stylua" },
	{ name = "shfmt" },
	{ name = "rustfmt", extra_args = { "--edition", "2021" } },
	{ name = "stylelint" },
	{
		name = "prettierd",
		---@usage arguments to pass to the formatter
		-- these cannot contain whitespace
		-- options such as `--line-width 80` become either `{"--line-width", "80"}` or `{"--line-width=80"}`
		---@usage only start in these filetypes, by default it will attach to all filetypes it supports
		filetypes = {
			"markdown",
			"sql",
			"lua",
			"typescript",
			"javascript",
			"javascriptreact",
			"typescriptreact",
		},
	},
	{
		name = "terraform_fmt",
		filetypes = {
			"tf",
      "terraform"
		},
	},
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{
		name = "shellcheck",
		args = { "--severity", "warning" },
	},
	{ name = "ruff" },
	{ name = "terraform_validate", filetypes = { "tf", "terraform" } },
	{ name = "eslint_d", filetypes = { "typescript", "typescriptreact" } },
})

local code_actions = require("lvim.lsp.null-ls.code_actions")
code_actions.setup({
	{
		name = "ltrs",
	},
})
