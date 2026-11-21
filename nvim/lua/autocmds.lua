require "nvchad.autocmds"

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.c", "*.cpp", "*.h", "*.hpp", "*.cc", "*.cxx" },
    callback = function()
        vim.lsp.buf.format {
            async = false,
            timeout_ms = 2000,
            filter = function(client)
                return client.name == "clangd"
            end,
        }
    end,
})

-- Prevent Treesitter decoration provider crashes on LSP hover float windows
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "lspinfo" },
    callback = function(args)
        local win = vim.fn.bufwinid(args.buf)
        -- Check if the buffer is rendered in a floating popup window
        if win ~= -1 and vim.api.nvim_win_get_config(win).relative ~= "" then
            pcall(vim.treesitter.stop, args.buf)
        end
    end,
})
