-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "horizon",
  -- default = onedark
  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

M.nvdash = { load_on_startup = true }

M.ui = {
  tabufline = {
    -- nvim-tree is docked on the right (see plugins/nvimtree.lua), so the
    -- blank tree-offset spacer must render last to line up with it instead
    -- of eating space on the left where the editor pane now starts
    order = { "buffers", "tabs", "btns", "treeOffset" },
  },
}

-- M.mappings = require("mappings")

return M
