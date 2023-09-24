---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>ws"] = { "<cmd> w <CR>", "save" },
    ["<leader>wq"] = { "<cmd> wq! <CR>", "save & quit" },
    ["<leader>q"] = { "<cmd> q! <CR>", "quit" }
  },
}

M.python_env = {
  plugin = true,
  n = {
    ["<leader>cc"] = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" }
  }
}

-- more keybinds!

return M
