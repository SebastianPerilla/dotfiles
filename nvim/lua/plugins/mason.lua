return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "mason-org/mason.nvim" },
  event = "VeryLazy",
  opts = {
    ensure_installed = {
      -- LSP servers (matches vim.lsp.enable list in configs/lsp/init.lua)
      "clangd",
      "pyright",
      "html-lsp",
      "css-lsp",
      "marksman",
      "cmake-language-server",
      -- formatters (matches configs/conform.lua)
      "stylua",
      "clang-format",
      "ruff",
    },
  },
  config = function(_, opts)
    require("mason-tool-installer").setup(opts)
  end,
}
