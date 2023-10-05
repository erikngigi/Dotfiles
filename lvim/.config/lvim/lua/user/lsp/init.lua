reload "user.lsp.languages.python"
reload "user.lsp.languages.sh"
-- reload "user.lsp.languages.markdown"

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "stylua",
    filetypes = { "lua" }
  },
  {
    command = "shfmt",
    filetypes = { "sh", "zsh" },
    extra_args = { "-i", "2", "-ci", "-bn" }
  },
  {
    command = "prettierd",
    filetypes = { "css", "scss", "less" }
  },
  {
    command = "markdownlint",
    filetypes = { "markdown" }
  },
}
