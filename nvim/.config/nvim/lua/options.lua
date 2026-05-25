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
        tf = "terraform",
        tfvars = "terraform-vars",
        nginx = "nginx",
    },
    filename = {
        ["nginx.conf"] = "nginx",
    },
})

-- Content-based Nginx detection for files without extensions
local function detect_nginx_by_content()
    local filename = vim.fn.expand("%:t")
    local current_ft = vim.bo.filetype

    -- Only proceed if:
    -- 1. File has no extension (no dot in filename), OR
    -- 2. Current filetype is empty or 'conf'
    local has_extension = filename:match("%.%w+$")

    if has_extension and current_ft ~= "" and current_ft ~= "conf" then
        return
    end

    -- Read first 150 lines
    local lines = vim.api.nvim_buf_get_lines(0, 0, 150, false)
    if #lines == 0 then
        return
    end

    local content = table.concat(lines, "\n")

    -- Primary Nginx indicators - these are very specific to Nginx
    local primary_patterns = {
        "server%s*{", -- server block
        "upstream%s+%w+", -- upstream block
        "location%s+", -- location directive
        "proxy_pass%s+", -- proxy_pass
    }

    -- Secondary Nginx indicators
    local secondary_patterns = {
        "listen%s+%d+",
        "server_name%s+",
        "proxy_set_header",
        "ssl_certificate",
        "client_max_body_size",
        "access_log%s+",
        "error_log%s+",
        "root%s+/",
        "add_header%s+",
    }

    -- Count primary matches
    local primary_count = 0
    for _, pattern in ipairs(primary_patterns) do
        if content:match(pattern) then
            primary_count = primary_count + 1
        end
    end

    -- Count secondary matches
    local secondary_count = 0
    for _, pattern in ipairs(secondary_patterns) do
        if content:match(pattern) then
            secondary_count = secondary_count + 1
        end
    end

    -- Decision logic:
    -- If we find 2+ primary patterns (like server + upstream), it's definitely nginx
    -- OR if we find 1 primary + 2+ secondary, it's nginx
    if primary_count >= 2 or (primary_count >= 1 and secondary_count >= 2) then
        vim.bo.filetype = "nginx"
        return true
    end

    return false
end

-- Run detection when files are opened
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*",
    callback = function()
        -- Use vim.schedule to avoid conflicts with other filetype detection
        vim.schedule(function()
            detect_nginx_by_content()
        end)
    end,
})

-- Override 'conf' filetype if it's actually nginx
vim.api.nvim_create_autocmd("FileType", {
    pattern = "conf",
    callback = function()
        vim.schedule(function()
            detect_nginx_by_content()
        end)
    end,
})
