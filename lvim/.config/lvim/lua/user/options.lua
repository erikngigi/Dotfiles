-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

lvim.colorscheme = "tokyonight"
-- vim.g.nightflyCursorColor = true
-- vim.g.nightflyItalics = true
-- vim.g.nightflyNormalFloat = true
-- vim.g.nightflyTerminalColors = true

lvim.log.level = "warn"
lvim.reload_config_on_save = true
lvim.builtin.illuminate.active = false
lvim.builtin.alpha.active = false
lvim.builtin.bufferline.active = true
lvim.builtin.breadcrumbs.active = false
lvim.builtin.dap.active = false
lvim.transparent_window = true
lvim.builtin.lualine.style = "lvim"
-- lvim.builtin.lualine.options.theme = "gruvbox"
lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = true
lvim.builtin.nvimtree.setup.view.adaptive_size = true
-- lvim.builtin.nvimtree.active = false -- NOTE: using neo-tree
lvim.builtin.project.manual_mode = true

-- vim options
vim.opt.wrap = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 15
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.g.nvim_tree_respect_buf_cwd = 1
-- vim.wo.foldmethod = "expr"
-- vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.wo.fillchars = "fold: "
-- vim.wo.foldnestmax = 3
-- vim.wo.foldminlines = 1
-- vim.wo.foldlevel = 1
-- vim.wo.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
