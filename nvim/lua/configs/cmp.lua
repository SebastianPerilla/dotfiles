dofile(vim.g.base46_cache .. "cmp")

local cmp = require "cmp"

local options = {
  -- completion behavior
  completion = {
    -- popup appears automatically *after* you type
    autocomplete = { cmp.TriggerEvent.TextChanged },
    completeopt = "menu,menuone",
    keyword_length = 2,  -- only suggest after 2 chars
  },

  -- ONLY use LSP as a source, and filter to variables/fields
  sources = {
    {
      name = "nvim_lsp",
      priority = 1000,
      entry_filter = function(entry, ctx)
        local kind = entry:get_kind()
        -- LSP kinds: 5 = Field, 6 = Variable
        return kind == 5 or kind == 6
      end,
    },
  },
}

-- IMPORTANT: load NvChad defaults first, then override with our options
return vim.tbl_deep_extend("force", require "nvchad.cmp", options)

