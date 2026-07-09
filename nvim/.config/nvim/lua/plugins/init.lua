return {
    {
        "nvimtools/none-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.none-ls")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.treesitter")
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require("configs.lspconfig")
        end,
    },
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.lint")
            -- 2. Create the autocommand to actually run the linters
            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        event = "BufWritePre", -- uncomment for format on save
        opts = require("configs.conform"),
    },
    {
        "zapling/mason-conform.nvim",
        event = "VeryLazy",
        dependencies = { "conform.nvim" },
        config = function()
            require("configs.mason-conform")
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lspconfig" },
        config = function()
            require("configs.mason-lspconfig")
        end,
    },
    {
        "rshkarin/mason-nvim-lint",
        event = "VeryLazy",
        dependencies = { "nvim-lint" },
        config = function()
            require("configs.mason-lint")
        end,
    },
    {
        "folke/which-key.nvim",
        lazy = false,
    },
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "NvChad/ui", -- load after nvchad ui
        },
        config = function()
            require("configs.lualine").setup()
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "onsails/lspkind.nvim", -- adds VS Code-like icons + type labels
        },
        config = function(_, opts)
            local cmp = require("cmp")
            local lspkind = require("lspkind")

            -- Key mappings
            local mymappings = {
                ["<Up>"] = cmp.mapping.select_prev_item(),
                ["<Down>"] = cmp.mapping.select_next_item(),
                ["<C-Up>"] = cmp.mapping.scroll_docs(-4),
                ["<C-Down>"] = cmp.mapping.scroll_docs(4),
                -- Confirm with Enter, fallback to newline
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                -- Manually trigger completion
                ["<C-Space>"] = cmp.mapping.complete(),
            }
            opts.mapping = vim.tbl_deep_extend("force", opts.mapping, mymappings)

            -- Add sources (order = priority)
            opts.sources = cmp.config.sources({
                { name = "nvim_lsp", priority = 1000 },
                { name = "nvim_lsp_signature_help", priority = 900 }, -- NEW: inline sig help
                { name = "luasnip", priority = 800 },
                { name = "buffer", priority = 500, keyword_length = 3 },
                { name = "path", priority = 300 },
            })

            -- Rich documentation formatting with lspkind
            opts.formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text", -- show icon + type name
                    maxwidth = 50,
                    ellipsis_char = "...",
                    show_labelDetails = true, -- shows detail like return type
                    before = function(entry, vim_item)
                        -- Show source name in menu column
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            nvim_lsp_signature_help = "[Sig]",
                            luasnip = "[Snip]",
                            buffer = "[Buf]",
                            path = "[Path]",
                        })[entry.source.name]
                        return vim_item
                    end,
                }),
            }

            -- Better completion window
            -- opts.window = {
            --     completion = cmp.config.window.bordered(),
            --     documentation = cmp.config.window.bordered(), -- bordered docs popup
            -- }

            -- Show completions even mid-word
            opts.completion = {
                completeopt = "menu,menuone,noinsert",
            }

            -- Prefer exact matches at top
            opts.sorting = {
                comparators = {
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.locality,
                    cmp.config.compare.kind,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            }

            cmp.setup(opts)
        end,
    },
    {
        "romainl/vim-cool",
        lazy = false,
    },
    {
        "linux-cultist/venv-selector.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } }, -- optional: you can also use fzf-lua, snacks, mini-pick instead.
        },
        ft = "python", -- Load when opening Python files
        keys = {
            { "<leader>v", "<cmd>VenvSelect<cr>", desc = "Select Python venv" }, -- Open picker on <leader>v
        },
        opts = { -- this can be an empty lua table - just showing below for clarity.
            search = {}, -- if you add your own searches, they go here.
            options = {}, -- if you add plugin options, they go here.
        },
    },
    {
        "nvim-tree/nvim-tree.lua",
        cmd = "NvimTreeToggle",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                view = {
                    width = 30,
                },
                renderer = {
                    root_folder_label = function(path)
                        return vim.fn.fnamemodify(path, ":t")
                    end,
                    icons = {
                        show = {
                            file = true,
                            folder = true,
                            folder_arrow = true,
                        },
                    },
                },
                actions = {
                    open_file = {
                        quit_on_open = true, -- Close tree after opening a file
                    },
                },
                filters = {
                    dotfiles = false,
                    -- custom = { "^.git$", "^.mypy_cache$", "^__pycache__$" }, -- Optional: still hide .git folder
                    custom = { "^.mypy_cache$", "^__pycache__$" }, -- Optional: still hide .git folder
                },
                view = {
                    width = 30,
                },
                filesystem_watchers = {
                    enable = true,
                    debounce_delay = 50,
                },
                git = {
                    enable = true,
                    ignore = false,
                },
            })
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    { -- This plugin
        "Zeioth/makeit.nvim",
        cmd = { "MakeitOpen", "MakeitToggleResults", "MakeitRedo" },
        dependencies = { "stevearc/overseer.nvim" },
        opts = {},
    },
    { -- The task runner we use
        "stevearc/overseer.nvim",
        commit = "400e762648b70397d0d315e5acaf0ff3597f2d8b",
        cmd = { "MakeitOpen", "MakeitToggleResults", "MakeitRedo" },
        opts = {
            task_list = {
                direction = "bottom",
                min_height = 25,
                max_height = 25,
                default_detail = 1,
            },
        },
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            -- Also load any custom snippets you place here:
            require("luasnip.loaders.from_vscode").lazy_load({
                paths = { vim.fn.stdpath("config") .. "/snippets" },
            })
            -- Enable autotriggered snippets
            require("luasnip").config.set_config({
                enable_autosnippets = true,
                history = true,
                updateevents = "TextChanged,TextChangedI",
            })
        end,
    },
    { "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },
}
