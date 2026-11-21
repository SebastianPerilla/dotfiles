require "nvchad.mappings"

local map = vim.keymap.set

-- General
map("n", ";", ":", { desc = "Enter command mode" })
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Tab skips past closing punctuation instead of indenting: either a run of
-- closers sitting right after the cursor on the same line (e.g. `(|)` -> `()|`),
-- or, from a blank line inside a block, the closers leading a later line
-- (e.g. `int main(){|\n};` -> jumps past `};`). Otherwise it indents as usual.
-- (tabout.nvim did this but its treesitter lookup silently no-ops under a
-- real Insert-mode keypress on this Neovim build, so it's done by hand here.)
local function smart_tabout()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    local after = line:sub(col + 1)

    local closers = after:match('^([%]%)}"\'`;,]+)')
    if closers then
        vim.api.nvim_win_set_cursor(0, { row, col + #closers })
        return
    end

    if line:sub(1, col):match("^%s*$") and after:match("^%s*$") then
        local last_line = vim.api.nvim_buf_line_count(0)
        for l = row + 1, last_line do
            local text = vim.api.nvim_buf_get_lines(0, l - 1, l, false)[1] or ""
            local lead, closer_run = text:match('^(%s*)([%]%)}"\'`;,]*)')
            if closer_run ~= "" then
                vim.api.nvim_win_set_cursor(0, { l, #lead + #closer_run })
                return
            elseif text:match("%S") then
                break
            end
        end
    end

    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
end

map("i", "<Tab>", smart_tabout, { desc = "Tab out of brackets/blocks, else indent" })

-- LSP
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("n", "gr", function()
    require("telescope.builtin").lsp_references({
        show_line = false,
    })
end, { desc = "Go to references (Telescope)" })

-- Debugging
map("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>", { desc = "Toggle breakpoint" })
map("n", "<leader>dr", "<cmd>DapContinue<cr>", { desc = "Start or continue debugger" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>")
