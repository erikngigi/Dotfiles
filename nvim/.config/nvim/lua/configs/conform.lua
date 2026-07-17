local options = {
    formatters_by_ft = {
        css = { "prettier" },
        dockerfile = { "dockerfmt" },
        hcl = { "terraform_fmt" },
        html = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
        make = { "mbake" },
        markdown = { "prettier" },
        python = {
            "ruff_organize_imports",
            "ruff_fix",
            "ruff_format",
        },
        scss = { "prettier" },
        sh = { "shfmt" },
        terraform = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
        tex = { "tex-fmt", "latexindent" },
        toml = { "taplo" },
        tf = { "terraform_fmt" },
        ["yaml.ansible"] = { "prettier" },
        yaml = { "yamlfmt" },
        zsh = { "shfmt" },
    },
    formatters = {
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
