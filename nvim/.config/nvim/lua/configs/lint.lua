local lint = require("lint")

lint.linters_by_ft = {
    dockerfile = { "hadolint" },
    html = { "htmlhint" },
    json = { "jsonlint" },
    -- javascript = { "eslint_d" },
    lua = { "luacheck" },
    make = { "checkmake" },
    markdown = { "proselint" },
    python = { "flake8" },
    scss = { "stylelint" },
    sh = { "shellcheck" },
    tex = { "vale" },
    yaml = { "yamllint" },
    zsh = { "shellcheck" },
}

lint.linters.luacheck.args = {
    unpack(lint.linters.luacheck.args),
    "--globals",
    "love",
    "vim",
}

lint.linters.hadolint.args = {
    unpack(lint.linters.hadolint.args),
    "--failure-threshold=warning",
    "--ignore=DL3008,DL3009", -- ignore specific rules
}

lint.linters.flake8.args = {
    unpack(lint.linters.flake8.args),
    "--max-line-length=150",
    "--ignore=E203,W503,E501",
    "--statistics",
}

lint.linters.shellcheck.args = {
    unpack(lint.linters.shellcheck.args),
    "--severity=style",
    "--enable=all",
}
