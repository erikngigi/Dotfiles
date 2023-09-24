local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    name = "black",
    args = { "--line-lenght=120" }
  },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    command = "flake8",
    args = { "--ignore=E203" },
    filetypes = { "python" }
  }
}

-- lvim.format_on_save = false
-- lvim.format_on_save.pattern = { "*.py" }
