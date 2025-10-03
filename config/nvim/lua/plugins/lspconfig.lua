return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    -- Import cmp-nvim-lsp for capabilities
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Enable autocompletion capabilities
    local capabilities = cmp_nvim_lsp.default_capabilities()



    vim.diagnostic.config({
    signs = {
      [vim.diagnostic.severity.ERROR] = { text = " ", texthl = "DiagnosticSignError" },
      [vim.diagnostic.severity.WARN]  = { text = " ", texthl = "DiagnosticSignWarn" },
      [vim.diagnostic.severity.HINT]  = { text = "󰠠 ", texthl = "DiagnosticSignHint" },
      [vim.diagnostic.severity.INFO]  = { text = " ", texthl = "DiagnosticSignInfo" },
      },
    })
    -- Configure Lua LSP using the new API
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    })

    -- Configure Nix LSP using the new API, with the original settings structure
    vim.lsp.config("nixd", {
      capabilities = capabilities,
      filetypes = { "nix" }, -- Restrict to .nix files
      settings = {
        nixd = {
          nixpkgs = {
            expr = "import <nixpkgs> { }",
          },
          formatting = {
            command = { "nixfmt" }, -- Ensure alejandra is in PATH
          },
          options = {
            nixos = {
              expr = '(builtins.getFlake "/home/cyril/path/to/flake").nixosConfigurations.your-config-name.options',
            },
            home_manager = {
              expr = '(builtins.getFlake "/home/cyril/path/to/flake").homeConfigurations.your-config-name.options',
            },
          },
        },
      },
    })

    -- Enable the configured language servers
    vim.lsp.enable({ "lua_ls", "nixd" })

  end,
}
