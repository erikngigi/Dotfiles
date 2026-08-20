local options = {
    ensure_installed = {
        "awk",
        "bash",
        "bibtex",
        "c",
        "cmake",
        "comment",
        "csv",
        "diff",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "go",
        "goctl",
        "html",
        "ini",
        "javascript",
        "jinja",
        "json",
        "lua",
        "luadoc",
        "make",
        "markdown",
        "markdown_inline",
        "printf",
        "nginx",
        "passwd",
        "python",
        "regex",
        "rust",
        "ssh_config",
        "tmux",
        "toml",
        "scss",
        "sql",
        "terraform",
        "vim",
        "vimdoc",
        "yaml",
        "xml",
    },

    highlight = {
        additional_vim_regex_highlighting = false,
        enable = true,
        use_languagetree = true,
        disable = function(_, buf)
            local max_filesize = 100 * 1024 -- 100KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
    },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
        },
    },
}

require("nvim-treesitter.configs").setup(options)

vim.treesitter.query.set("dockerfile", "injections", "")
