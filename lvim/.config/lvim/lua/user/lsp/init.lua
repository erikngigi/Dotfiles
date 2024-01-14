reload "user.lsp.languages.python"
reload "user.lsp.languages.sh"

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "shfmt",
    filetypes = { "sh", "zsh" },
    extra_args = { "-i", "2", "-ci", "-bn" }
  },
  {
    command = "prettierd",
    filetypes = { "html", "css", "scss", "less" }
  },
  {
    command = "markdownlint",
    filetypes = { "markdown" }
  },
}
