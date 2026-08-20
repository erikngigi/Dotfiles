local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities
local lspconfig = require("nvchad.configs.lspconfig") -- nvim 0.11

-- List of all servers configured
lspconfig.servers = {
    "ansiblels",
    "bashls",
    "basedpyright",
    "cssls",
    "docker_compose_language_service",
    "dockerls",
    "gopls",
    "jsonls",
    "html",
    "lua_ls",
    "marksman",
    "ruff",
    "systemd_lsp",
    "taplo",
    "terraformls",
    "texlab",
    "ts_ls",
    "yamlls",
}

-- List of servers configured with default config
local default_servers = {
    "cssls",
    "jsonls",
    "systemd_lsp",
    "texlab",
    "ts_ls",
}

-- LSPs with default config
for _, lsp in ipairs(default_servers) do
    vim.lsp.config(lsp, {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
    })
end

vim.lsp.enable(default_servers)

-- Ansible LSP custom settings
vim.lsp.config("ansiblels", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    filetypes = { "yaml.ansible" },
    root_markers = { "ansible.cfg", ".git" },
    settings = {
        ansible = {
            ansible = {
                useFullyQualifiedCollectionNames = true,
                path = "/usr/bin/ansible",
            },
            completion = {
                provideRedirectModules = true,
                provideModuleOptionAliases = true,
            },
            python = {
                interpreterPath = "/usr/bin/python3",
            },
            telemetry = {
                enabled = false,
            },
            validation = {
                enabled = false,
                lint = {
                    enabled = false,
                },
            },
        },
    },
})
vim.lsp.enable("ansiblels")

-- Bashls with custom settings
vim.lsp.config("bashls", {
    on_attach = on_attach, -- your on_attach function
    on_init = on_init, -- your on_init function
    capabilities = capabilities, -- your capabilities
    filetypes = { "sh", "bash", "make" },
    settings = {
        bashIde = {
            backgroundAnalysisMaxFiles = 500,
            enableSourceErrorDiagnostics = false,
            explainshellEndpoint = "",
            globPattern = "**/*@(.sh|.inc|.bash|.command)",
            includeAllWorkspaceSymbols = false,
            logLevel = "info",
            shellcheckArguments = "",
            shellcheckPath = "",
            shfmt = {
                binaryNextLine = false,
                caseIndent = false,
                funcNextLine = false,
                ignoreEditorconfig = false,
                keepPadding = false,
                languageDialect = "auto",
                path = "shfmt",
                simplifyCode = false,
                spaceRedirects = false,
            },
        },
    },
})
vim.lsp.enable("bashls")

-- BasedPyright LSP custom settings
vim.lsp.config("basedpyright", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    root_markers = { "pyproject.toml", "uv.lock", ".git" },
    settings = {
        python = {
            venvPath = ".",
            venv = "venv",
        },
        basedpyright = {
            analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                typeCheckingMode = "off", -- options: off, basic, standard, strict, all
                useLibraryCodeForTypes = true,
                pythonPlatform = "Linux",
                diagnosticMode = "openFilesOnly",
            },
        },
    },
})
vim.lsp.enable("basedpyright")

-- Config-lsp custom settings
vim.lsp.config("config_lsp", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    cmd = { "/usr/local/bin/config-lsp" },
    filetypes = {
        "sshconfig",
        "sshdconfig",
        "fstab",
        "aliases",
        "gitconfig",
        "hosts",
    },
    root_markers = { ".git" },
})
vim.lsp.enable("config_lsp")

-- Denols LSP custom settings
vim.lsp.config("denols", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,

    root_markers = { "deno.json", "deno.jsonc" },

    settings = {
        deno = {
            enable = true,
            lint = true,
            unstable = false, -- Set true if you use unstable APIs
            suggest = {
                completeFunctionCalls = true,
                imports = {
                    autoDiscover = true,
                },
            },
            codeLens = {
                implementations = true,
                references = true,
                referencesAllFunctions = true,
                test = true,
            },
            inlayHints = {
                enumMemberValues = true,
                functionLikeReturnTypes = true,
                parameterNames = true,
                parameterTypes = true,
                propertyDeclarationTypes = true,
                variableTypes = true,
            },
        },
    },
})
vim.lsp.enable("denols")

-- Docker compose LSP custom settings
vim.lsp.config("docker_compose_language_service", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    filetypes = { "yaml.docker-compose" },
    root_markers = { "docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml" },
})
vim.lsp.enable("docker_compose_language_service")

-- Dockerfile LSP with custom settings
vim.lsp.config("dockerls", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    cmd = { "docker-langserver", "--stdio" },
    filetypes = { "dockerfile" },
    root_dir = vim.fs.root(0, { "Dockerfile", ".git" }),
    settings = {
        docker = {
            languageserver = {
                diagnostics = {
                    deprecatedMaintainer = "warning",
                    directiveCasing = "warning",
                    emptyContinuationLine = "warning",
                    instructionCasing = "warning",
                    instructionCmdMultiple = "warning",
                    instructionEntrypointMultiple = "warning",
                    instructionHealthcheckMultiple = "warning",
                    instructionJSONInSingleQuotes = "warning",
                },
                formatter = {
                    ignoreMultilineInstructions = false,
                },
            },
        },
    },
})
vim.lsp.enable("dockerls")

-- GO LSP custom settings
vim.lsp.config("gopls", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.work", "go.mod", ".git" },
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
            },
        },
    },
})
vim.lsp.enable("gopls")

-- HTML LSP custom settings
vim.lsp.config("html", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    filetypes = { "html", "handlebars", "hbs" },
    settings = {
        html = {
            -- Auto-closing and quotes
            autoClosingTags = true,
            autoCreateQuotes = true,

            -- Completion
            completion = {
                attributeDefaultValue = "doublequotes",
            },

            -- Formatting (most important)
            format = {
                enable = true,
                contentUnformatted = "pre,code,textarea",
                extraLiners = "head, body, /html",
                indentHandlebars = true,
                indentInnerHtml = false,
                preserveNewLines = true,
                templating = true,
                unformatted = "wbr",
                unformattedContentDelimiter = "",
                wrapAttributes = "auto",
                wrapLineLength = 150,
            },

            -- Hover and suggestions
            hover = {
                documentation = true,
                references = true,
            },
            suggest = {
                html5 = true,
                hideEndTagSuggestions = false,
            },

            -- Validation
            validate = {
                scripts = true,
                styles = true,
            },

            -- Mirror cursor on matching tags
            mirrorCursorOnMatchingTag = true,
        },
    },
})
vim.lsp.enable("html")

-- JinjaLSP custom settings
-- vim.lsp.config("jinja_lsp", {
--     on_attach = on_attach,
--     on_init = on_init,
--     capabilities = capabilities,
--     filetypes = { "jinja" },
--     root_markers = { "ansible.cfg", ".git" },
--     settings = {
--         backend = { "./vars", "./defaults", "./roles", "./" },
--         hide_undefined = true,
--         lang = "python",
--         template_extension = { "j2", "jinja2", "jinja" },
--         templates = "./templates",
--     },
-- })
-- vim.lsp.enable("jinja_lsp")

-- Lua LSP custom setup
vim.lsp.config("lua_ls", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                enable = false, -- Disable all diagnostics from lua_ls
            },
            workspace = {
                library = {
                    vim.fn.expand("$VIMRUNTIME/lua"),
                    vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                    vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
                    vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
                    "${3rd}/love2d/library",
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
})
vim.lsp.enable("lua_ls")

vim.lsp.config("marksman", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    filetypes = { "markdown", "markdown.mdx" },
    root_markers = { ".marksman.toml", ".git" },
})
vim.lsp.enable("marksman")

-- Nginx LSP configuration
vim.lsp.config("nginx_language_server", {
    cmd = { "nginx-language-server" },
    filetypes = { "nginx" },
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
})
vim.lsp.enable("nginx_language_server")

-- Ruff LSP custom settings
vim.lsp.config("ruff", {
    on_attach = function(client, bufnr)
        client.server_capabilities.hoverProvider = false
        client.server_capabilities.diagnosticsProvider = false -- nvim-lint handles this
        on_attach(client, bufnr)
    end,
    on_init = on_init,
    capabilities = capabilities,
    root_markers = { "pyproject.toml", "ruff.toml", ".git" },
    init_options = {
        settings = {
            lint = { enable = true }, -- nvim-lint handles diagnostics
            organizeImports = true, -- LSP handles fix via code action
        },
    },
})
vim.lsp.enable("ruff")

-- Terraform LSP (terraformls) custom setup
vim.lsp.config("terraformls", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    cmd = { "terraform-ls", "serve" },
    filetypes = { "terraform", "terraform-vars", "tf", "tfvars" },
    root_markers = { ".terraform", ".git" },
})
vim.lsp.enable("terraformls")

-- Taplo LSP (TOML)
vim.lsp.config("taplo", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    filetypes = { "toml" },
    root_markers = { ".git", "pyproject.toml", "Cargo.toml", ".taplo.toml" },
})
vim.lsp.enable("taplo")

-- Yaml LSP (Yamlls) custom setup
vim.lsp.config("yamlls", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    -- 1. Allow yamlls to attach to both standard YAML and Ansible files
    filetypes = { "yaml" },
    settings = {
        yaml = {
            completion = true,
            disableAdditionalProperties = false,
            format = {
                enable = true,
                printWidth = 120,
                proseWrap = "preserve",
                singleQuote = true,
            },
            hover = true,
            maxItemsComputed = 5000,
            validate = true,

            -- 2. Keep the automatic schema downloader disabled
            schemaStore = {
                enable = false,
                url = "",
            },

            -- 3. Explicitly pair schemas to files (they will never cross-pollinate)
            schemas = {
                -- Docker Compose Schema (Only matches Docker files)
                ["https://raw.githubusercontent.com/compose-spec/compose-go/master/schema/compose-spec.json"] = {
                    "**/docker-compose.yml",
                    "**/docker-compose.yaml",
                    "**/docker-compose.*.yml",
                    "**/docker-compose.*.yaml",
                    "**/compose.yml",
                    "**/compose.yaml",
                    "**/compose.*.yml",
                    "**/compose.*.yaml",
                },

                ["https://www.schemastore.org/github-workflow.json"] = {
                    "**/.github/workflows/*.yml",
                    "**/.github/workflows/*.yaml",
                    "**/.gitea/workflows/*.yml",
                    "**/.gitea/workflows/*.yaml",
                    "**/.forgejo/workflows/*.yml",
                    "**/.forgejo/workflows/*.yaml",
                },

                -- Ansible Playbook Schema (Only matches playbooks)
                -- ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook"] = {
                --     "playbook.yml",
                --     "playbook.yaml",
                --     "site.yml",
                --     "site.yaml",
                --     "**/playbooks/*.yml",
                --     "**/playbooks/*.yaml",
                -- },
                --
                -- -- Ansible Tasks Schema (Only matches files inside tasks/ or handlers/)
                -- ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/tasks"] = {
                --     "**/tasks/*.yml",
                --     "**/tasks/*.yaml",
                --     "**/handlers/*.yml",
                --     "**/handlers/*.yaml",
                -- },
                --
                -- -- Ansible Variables Schema (Only matches host/group/role vars)
                -- ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/vars.json"] = {
                --     "**/vars/*.yml",
                --     "**/vars/*.yaml",
                --     "**/host_vars/*.yml",
                --     "**/host_vars/*.yaml",
                --     "**/group_vars/*.yml",
                --     "**/group_vars/*.yaml",
                -- },
                --
                -- -- Ansible Inventory Schema (Only matches inventory files)
                -- ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/inventory.json"] = {
                --     "inventory.yml",
                --     "inventory.yaml",
                -- },
            },
        },
    },
})
vim.lsp.enable("yamlls")
