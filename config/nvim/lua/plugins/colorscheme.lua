return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha", -- Options: latte, frappe, macchiato, mocha
            integrations = {
                treesitter = true,
                native_lsp = { enabled = true },
                cmp = true,
                gitsigns = true,
                telescope = true,
                notify = true,
                mini = true,
            }
        })

        vim.cmd.colorscheme "catppuccin"
    end
}

