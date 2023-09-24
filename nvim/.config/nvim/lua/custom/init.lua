-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
   pattern = "text",
   callback = function()
      require("cmp").setup.buffer { enabled = false }
   end,
})

autocmd("FileType", {
   pattern = "plain text",
   callback = function()
      require("cmp").setup.buffer { enabled = false }
   end,
})

autocmd("FileType", {
   pattern = "conf",
   callback = function()
      require("cmp").setup.buffer { enabled = false }
   end,
})

autocmd("FileType", {
   pattern = "hlsplaylist",
   callback = function()
      require("cmp").setup.buffer { enabled = false }
   end,
})
