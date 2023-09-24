-- custom keybindings
lvim.keys.normal_mode["<Space>n"] = "<cmd>NvimTreeFocus<cr>"
-- lvim.keys.normal_mode["<Space>w"] = "<cmd>w<cr>"
-- lvim.keys.normal_mode["<Space>wq"] = "<cmd>quitall<cr>"
lvim.keys.normal_mode["<TAB>"] = "<cmd>BufferLineCycleNext<cr>"
lvim.builtin.which_key.mappings["w"] = {
  name = "Save Options",
  w = { "<cmd>w<cr>", "save" },
  q = { "<cmd>quitall<cr>", "quit all" }
}

-- null-ls timeout
lvim.builtin.which_key.mappings["l"]["f"] = {
  function()
    require("lvim.lsp.utils").format { timeout_ms = 2000 }
  end,
  "Format",
}

-- switch python environment
lvim.builtin.which_key.mappings["p"] = {
  name = "Python",
  p = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}
