-- custom keybindings
lvim.keys.normal_mode["<TAB>"] = "<cmd>BufferLineCycleNext<cr>"
lvim.builtin.which_key.mappings["w"] = {
	name = "File Options",
	w = { "<cmd>w<cr>", "save" },
	q = { "<cmd>quitall<cr>", "quit all" },
}
lvim.builtin.which_key.mappings["b"] = {
	name = "Browser",
	b = { "<cmd>!brave '%'<cr>", "Open In Brave" },
}

-- null-ls timeout
lvim.builtin.which_key.mappings["l"]["f"] = {
	function()
		require("lvim.lsp.utils").format({ timeout_ms = 10000 })
	end,
	"Format",
}

-- switch python environment
lvim.keys.normal_mode["ce"] = "<cmd>lua require('swenv.api').pick_venv()<cr>"

-- Neotree --
-- lvim.builtin.which_key.mappings["e"] = {}
-- lvim.keys.normal_mode["<leader>e"] = ":Neotree reveal toggle<CR>"

-- Make file executable
lvim.keys.normal_mode["<leader>x"] = "<cmd>!chmod +x %<CR>"
