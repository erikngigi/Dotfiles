local options = {
    formatters_by_ft = {
        css = { "prettierd" },
        dart = { "dart_format" },
        dockerfile = { "dockerfmt" },
        hcl = { "terraform_fmt" },
        html = { "prettierd" },
        json = { "prettierd" },
        lua = { "stylua" },
        make = { "mbake" },
        markdown = { "prettierd" },
        python = {
            "ruff_organize_imports",
            "ruff_fix",
            "ruff_format",
        },
        scss = { "prettierd" },
        sh = { "shfmt" },
        terraform = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
        tex = { "tex-fmt", "latexindent" },
        toml = { "taplo" },
        tf = { "terraform_fmt" },
        yaml = { "yamlfmt" },
        zsh = { "shfmt" },
    },
    formatters = {
        dart_format = {
            command = "dart",
            args = { "format", "$FILENAME" },
            stdin = false,
        },
        dockerfmt = {
            command = "dockerfmt",
            prepend_args = {
                "-i",
                "4",
            },
            stdin = true,
        },
        mbake = {
            command = "mbake",
            args = { "format", "$FILENAME" },
            stdin = false,
        },
        shfmt = {
            prepend_args = {
                "-i",
                "2",
                "-bn",
                "-ci",
            },
        },
        ["tex-fmt"] = {
            prepend_args = {
                "--wraplen",
                "150",
                "--tabsize",
                "4",
            },
            stdin = true,
        },
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 5000,
        lsp_fallback = true,
    },
}

return options
