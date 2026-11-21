return {
    "hrsh7th/nvim-cmp",
    opts = function()
        local cmp = require "cmp"
        local types = require "cmp.types"
        local opts = require "nvchad.configs.cmp"

        opts.completion = vim.tbl_deep_extend("force", opts.completion or {}, {
            autocomplete = { cmp.TriggerEvent.TextChanged },
            completeopt = "menu,menuone",
            keyword_length = 1,
        })

        opts.performance = vim.tbl_deep_extend("force", opts.performance or {}, {
            max_view_entries = 8,
        })

        opts.sources = {
            {
                name = "nvim_lsp",
                priority = 1000,
                entry_filter = function(entry)
                    local kind = entry:get_kind()

                    local allowed = {
                        [types.lsp.CompletionItemKind.Function]    = true,
                        [types.lsp.CompletionItemKind.Method]      = true,
                        [types.lsp.CompletionItemKind.Constructor] = true,
                        [types.lsp.CompletionItemKind.Variable]    = true,
                        [types.lsp.CompletionItemKind.Field]       = true,
                        [types.lsp.CompletionItemKind.Class]       = true,
                        [types.lsp.CompletionItemKind.Struct]      = true,
                    }

                    return allowed[kind] or false
                end,
            },
            {
                name = "buffer",
                priority = 900,
                option = {
                    get_bufnrs = function()
                        return { vim.api.nvim_get_current_buf() }
                    end,
                },
            },
        }
        opts.mapping = cmp.mapping.preset.insert({
            ["<CR>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            }),
        })

        return opts
    end,
}
