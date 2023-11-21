if not require("config").pdenv.python then
  return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "ninja", "python", "rst", "toml" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff_lsp = {},
        pyright = {
          settings = {
            python = {
              analysis = {
                autoImportCompletions = true,
                typeCheckingMode = "off",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
                stubPath = vim.fn.stdpath "data" .. "/lazy/python-type-stubs/stubs",
              },
            }
          }
        }
      },
      setup = {
        ruff_lsp = function()
          local utils = require("plugins.lsp.utils")
          utils.on_attach(function(client, _)
            if client.name == "ruff_lsp" then
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
        pyright = function(_, _)
          local utils = require("plugins.lsp.utils")
          utils.on_attach(function(client, bufnr)
            local keymap = utils.keymap
            if client.name == "pyright" then
              keymap("n", "<leader>lo", "<cmd>PyrightOrganizeImports<cr>", { desc = "Organize Imports" })
              keymap("n", "<leader>dC", function() require("dap-python").test_class() end, { desc = "Debug Class" })
              keymap("n", "<leader>dM", function() require("dap-python").test_method() end, { desc = "Debug Method" })
              keymap("v", "<leader>dE", function() require("dap-python").debug_selection() end,
                { desc = "Debug Selection" })
            end
          end)
        end
      }
    }
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      config = function()
        local path = require("mason-registry").get_package("debugpy"):get_install_path()
        require("dap-python").setup(path .. "/venv/bin/python")
      end,
    },
  }
}
