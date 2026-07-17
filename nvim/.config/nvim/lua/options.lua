require("nvchad.options")

-- add yours here!
local o = vim.o

-- Indenting
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2

-- Backups
o.backup = false
o.writebackup = false
o.swapfile = false

-- Diagnostic configuration
vim.diagnostic.config({
    virtual_text = {
        prefix = "●", -- Custom symbol before message
        format = function(diagnostic)
            return diagnostic.message
        end,
    },
    signs = true, -- Show E/W icons in left gutter
    underline = true, -- Underline problematic code
    update_in_insert = false, -- Don't update diagnostics while typing
    severity_sort = true, -- Sort by severity (errors first)
})

-- Filetype detection
vim.filetype.add({
    extension = {
        ["yaml.ansible"] = "yaml.ansible",
        tf = "terraform",
        tfvars = "terraform-vars",
    },
})

-- Reclassify .yml/.yaml files as "yaml.ansible" when:
-- 1. An ansible root marker is found
-- 2. The file is in a standard Ansible directory (tasks, roles, handlers, group_vars, etc.)
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.yml", "*.yaml" },
    callback = function(args)
        local path = vim.api.nvim_buf_get_name(args.buf)

        -- Check for root markers first[cite: 3]
        local root = vim.fs.root(args.buf, { "ansible.cfg" })

        -- Check for common Ansible folder paths
        local is_ansible_path = path:match("/tasks/")
            or path:match("/handlers/")
            or path:match("/roles/")
            or path:match("/group_vars/")
            or path:match("/host_vars/")
            or path:match("/playbooks/")

        if root or is_ansible_path then
            vim.bo[args.buf].filetype = "yaml.ansible"
        end
    end,
})

local function manage_lsp_log()
    local log_path = vim.lsp.get_log_path()
    local max_size = 10 * 1024 * 1024 -- 10MB in bytes

    -- vim.fn.getfsize returns size in bytes. Returns -1 if file doesn't exist.
    local file_size = vim.fn.getfsize(log_path)

    if file_size > max_size then
        -- Open in write mode ("w") to truncate the file to 0 bytes
        local f = io.open(log_path, "w")
        if f then
            f:write("")
            f:close()
            vim.notify("LSP log exceeded 10MB and has been cleared.", vim.log.levels.INFO, { title = "NvChad System" })
        end
    end
end

-- Trigger the check automatically every time Neovim starts up
vim.api.nvim_create_autocmd("VimEnter", {
    callback = manage_lsp_log,
})
