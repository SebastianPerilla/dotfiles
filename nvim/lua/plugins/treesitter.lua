-- lua/plugins/treesitter.lua
return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    opts = {
        ensure_installed = {
            "lua",
            "vim",
            "vimdoc",
            "python",
            "cpp",
            "c",
            "markdown",
            "markdown_inline",
        },
    },
    config = function(_, opts)
        require("nvim-treesitter").setup(opts)
        require("nvim-treesitter").install(opts.ensure_installed)
    end,
}
