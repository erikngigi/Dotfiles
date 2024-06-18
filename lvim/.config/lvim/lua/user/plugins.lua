lvim.plugins = {
  { "HiPhish/rainbow-delimiters.nvim" },
  { "NvChad/nvim-colorizer.lua" },

  -- colorschemes
  { "folke/tokyonight.nvim" },
  { "Mofiqul/dracula.nvim" },
  { "folke/tokyonight.nvim" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- terraform 
  { "hashivim/vim-terraform" },

  -- -- neotree
  -- {
  -- "nvim-neo-tree/neo-tree.nvim",
  -- branch = "v3.x",
  -- dependencies = {
  --   "nvim-lua/plenary.nvim",
  --   "nvim-tree/nvim-web-devicons",
  --   "MunifTanjim/nui.nvim",
  --   },
  -- },

  -- python environments
  { "AckslD/swenv.nvim" },
  { "stevearc/dressing.nvim" },

  -- markdown preview
  {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
  },
}

require('swenv').setup({
  post_set_venv = function()
    vim.cmd("LspRestart")
  end,
})
