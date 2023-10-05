local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    name = "black",
  },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    command = "flake8",
    filetypes = { "python" },
    args = { "--ignore=E203, E266, E501, W503, F403, F401",
             "--max-line-lenght=88",
             "--max-complexity=18",
             "--select=B,C,E,F,W,T4,B9"},
  }
}
