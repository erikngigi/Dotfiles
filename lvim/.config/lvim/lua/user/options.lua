-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

lvim.colorscheme = "nightfly"
vim.g.nightflyCursorColor = true
vim.g.nightflyItalics = true
vim.g.nightflyNormalFloat = true
vim.g.nightflyTerminalColors = true

lvim.log.level = "warn"
lvim.reload_config_on_save = true
lvim.builtin.illuminate.active = false
lvim.builtin.alpha.active = false
lvim.builtin.bufferline.active = true
lvim.builtin.breadcrumbs.active = false
lvim.builtin.dap.active = false
lvim.transparent_window = true
lvim.builtin.lualine.style = "lvim"
lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = true
lvim.builtin.nvimtree.setup.view.adaptive_size = true
lvim.builtin.nvimtree.active = false -- NOTE: using neo-tree
lvim.builtin.project.manual_mode = true

-- vim options
vim.opt.wrap = true
-- vim.opt.autochdir = true
