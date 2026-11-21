-- lua/configs/lspconfig.lua
local nvlsp = require "nvchad.configs.lspconfig"

nvlsp.defaults()

-- Pass ONLY valid command-line flags to clangd
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    -- Directs clangd to check GCC 14 headers
    "--query-driver=/usr/bin/g++-14,/usr/bin/g++,**/.pixi/envs/*/bin/*++",
  },
  -- Fallback flags are not a CLI option; they go through init_options
  init_options = {
    fallbackFlags = { "-std=c++23" },
  },
})

vim.lsp.config("pyright", {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic", -- or "strict"
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})

local servers = { "html", "cssls", "clangd", "marksman", "cmake", "pyright" }
vim.lsp.enable(servers)

-- Show the full diagnostic below the line, only for the line the cursor is
-- on. virtual_lines does not wrap on its own, but it draws each "\n" in the
-- message as its own line, so wrap the text to the window width here.
local function wrap_diagnostic(diagnostic)
  local msg = diagnostic.code and (diagnostic.code .. ": " .. diagnostic.message) or diagnostic.message

  local win = vim.api.nvim_get_current_win()
  local textoff = vim.fn.getwininfo(win)[1].textoff
  local line = vim.api.nvim_buf_get_lines(diagnostic.bufnr, diagnostic.lnum, diagnostic.lnum + 1, false)[1] or ""
  local col = vim.fn.strdisplaywidth(line:sub(1, diagnostic.col))
  -- 6 = width of the "└──── " connector drawn before the message
  local width = math.max(vim.api.nvim_win_get_width(win) - textoff - col - 6 - 1, 20)

  local out = {}
  for _, para in ipairs(vim.split(msg, "\n")) do
    local cur = ""
    for word in para:gmatch "%S+" do
      if cur == "" then
        cur = word
      elseif #cur + 1 + #word <= width then
        cur = cur .. " " .. word
      else
        table.insert(out, cur)
        cur = word
      end
    end
    table.insert(out, cur)
  end
  return table.concat(out, "\n")
end

vim.diagnostic.config {
  virtual_text = false,
  virtual_lines = { current_line = true, format = wrap_diagnostic },
}
