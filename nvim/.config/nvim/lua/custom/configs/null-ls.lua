local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css", "yaml", "json" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- Shell
   b.formatting.shfmt,
   b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

  -- python
  b.formatting.black.with { filetypes = { "python" }, extra_args = { "--preview", "--line-length=120" } },
  b.formatting.isort.with { filetypes = { "python" }, extra_args = { "--filter-files", "--profile=black" } },
  b.diagnostics.ruff.with {
    filetypes = { "python" },
    extra_args = {
      "--line-length=120",
      "--extend-select=D,N,W,I,G",
      "--per-file-ignores=tests/*: D",
      "--dummy-variable-rgx=^_$",
      "--ignore=G004",
      "--ignore=D100",
      "--ignore=D101",
      "--ignore=D102",
      "--ignore=D103",
    },
  },
  b.diagnostics.mypy.with {
    filetypes = { "python" },
    extra_args = { "--ignore-missing-imports", "--scripts-are-modules" },
  },
}

null_ls.setup {
  debug = true,
  sources = sources,
}
