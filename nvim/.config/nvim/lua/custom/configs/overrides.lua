local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "python",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- python stuff
    "black",
    "flake8",
    "pyright",

    -- shell
    "bash-language-server",
    "shfmt",
    "shellcheck"
  },
}

-- git support in nvimtree
M.nvimtree = {
  view = {
    centralize_selection = true,
  },
  git = {
    enable = true,
  },

  actions = {
    open_file = {
      quit_on_open = true,
    },
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
  update_focused_file = {
    enable = true,
    update_root = true,
  },
}

return M
