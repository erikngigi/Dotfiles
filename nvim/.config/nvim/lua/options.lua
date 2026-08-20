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
        j2 = "jinja",
        jinja2 = "jinja",
        jinja = "jinja",
        service = "systemd",
        timer = "systemd",
        target = "systemd",
        mount = "systemd",
        socket = "systemd",
        tf = "terraform",
        tfvars = "terraform-vars",
    },
    pattern = {
        [".*/etc/nginx/.*"] = "nginx",
        [".*/nginx/.*"] = "nginx",
    },
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
