require "nvchad.options"

local opt = vim.opt

opt.number = true         -- show absolute line number on current line
opt.relativenumber = true -- show relative numbers on other lines
opt.cursorline = true     -- highlight the current line
opt.numberwidth = 4       -- gutter width like your screenshot

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.scrolloff = 10 -- or 15 if you prefer

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
