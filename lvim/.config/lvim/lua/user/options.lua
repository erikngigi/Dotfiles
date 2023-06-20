-- neovim options
vim.opt.cmdheight = 1             -- more space in the neovim command line for displaying messages
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.shiftwidth = 2            -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2               -- insert 2 spaces for a tab
vim.opt.relativenumber = false    -- relative line numbers
vim.opt.wrap = true               -- wrap lines
vim.o.linebreak = true

lvim.log.level = "warn"
lvim.format_on_save = true

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "html",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "yaml"
}

-- custom in-built configurations
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.project.detection_methods = { "lsp", "pattern" }
lvim.builtin.project.patterns = {
  ".git",
  "package-lock.json",
  "yarn.lock",
  "package.json",
  "requirements.txt"
}
lvim.builtin.alpha.active = false
lvim.builtin.dap.active = false
lvim.builtin.cmp.completion.keyword_length = 1
lvim.transparent_window = true
