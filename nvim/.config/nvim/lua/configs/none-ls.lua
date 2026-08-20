local null_ls = require("null-ls")

-- Formatters
local formatters = {
    -- Go Formatters
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.goimports_reviser,
    null_ls.builtins.formatting.golines,
}

-- Diagnostics
local diagnostics = {
    -- Terraform
    null_ls.builtins.diagnostics.terraform_validate.with({
        filetypes = { "hcl", "terraform", "terraform-vars", "tf" },
        cwd = function(params)
            return vim.fn.fnamemodify(vim.fn.finddir("provider.tf", vim.fn.expand("%:p:h") .. ";"), ":h")
        end,
    }),
    null_ls.builtins.diagnostics.golangci_lint,
    null_ls.builtins.diagnostics.ansiblelint.with({
        filetypes = { "yaml.ansible" },
    }),
}

local sources = {}
for _, formatter in ipairs(formatters) do
    table.insert(sources, formatter)
end
for _, diagnostic in ipairs(diagnostics) do
    table.insert(sources, diagnostic)
end

null_ls.setup({
    sources = sources,
})
