return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
      "simrat39/rust-tools.nvim",
    }
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "rust_analyzer", "tsserver", "lua_ls", "eslint" },
        automatic_installation = true,
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup {
              on_attach = require("plugins.lsp.utils").on_attach(function(client, bufnr)
                require("plugins.lsp.keymaps").setup(client, bufnr)
                require("plugins.lsp.utils").format(client, bufnr)
                local navic_ok, navic = pcall(require, "nvim-navic")
                if navic_ok and client.server_capabilities.documentSymbolProvider then
                  navic.attach(client, bufnr)
                end
              end),
              capabilities = require("plugins.lsp.utils").capabilities()
            }
          end
        }
      }
    end
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup {
        ensure_installed = { "codelldb" },
        ui = {
          icons = {
            package_installed = "󰏓 ",
            package_pending = "󰔾 ",
            package_uninstalled = "󱧗 "
          }
        }
      }
    end
  }
}
