if not require("config").pdenv.rust then
  return {}
end

local function get_codelldb()
  local mason_registry = require "mason-registry"
  local codelldb = mason_registry.get_package "codelldb"
  local extension_path = codelldb:get_install_path() .. "/extension/"
  local codelldb_path = extension_path .. "adapter/codelldb"
  local liblldb_path = ""
  if vim.loop.os_uname().sysname:find "Windows" then
    liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
  elseif vim.fn.has "mac" == 1 then
    liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
  else
    liblldb_path = extension_path .. "lldb/lib/liblldb.so"
  end
  return codelldb_path, liblldb_path
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "ron", "rust", "toml" })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "codelldb" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "simrat39/rust-tools.nvim" },
    opts = {
      servers = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                features = "all"
              },
              checkOnSave = true,
              check = {
                enable = true,
                features = "all",
                command = "clippy",
                extraArgs = { "--", "-W", "clippy::pedantic" },
              }
            }
          }
        }
      },
      setup = {
        rust_analyzer = function(_, opts)
          local codelldb_path, liblldb_path = get_codelldb()
          local utils = require("plugins.lsp.utils")
          utils.on_attach(function(client, bufnr)
            local keymap = utils.keymap
            if client.name == "rust_analyzer" then
              keymap({ "n", "v" }, "K", require("rust-tools").hover_actions.hover_actions, { desc = "Hover" })
              keymap("n", "<localleader>rr", "<cmd>RustRunnables<CR>", { desc = "Run" })
              keymap("n", "<localleader>rc", "<cmd>RustOpenCargo<CR>", { desc = "Open Cargo.toml" })
            end
          end)

          require("rust-tools").setup {
            tools = {
              hover_actions = { border = "solid" },
              runnables = {
                use_telescope = true,
              },
              inlay_hints = {
                auto = true,
                show_parameter_hints = true,
              },
            },
            dap = { adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path) },
            server = opts,
          }
          return true
        end
      }
    }
  },
  {
    "mfussenegger/nvim-dap",
    opts = {
      setup = {
        codelldb = function()
          local codelldb_path, _ = get_codelldb()
          local dap = require("dap")

          dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
              command = codelldb_path,
              args = { "--port", "${port}" }
            }
          }

          dap.configurations.cpp = {
            {
              name = "Launch file",
              type = "codelldb",
              request = "launch",
              program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
              end,
              cwd = '${workspaceFolder}',
              stopOnEntry = false,
            },
          }

          dap.configurations.c = dap.configurations.cpp
          dap.configurations.rust = dap.configurations.cpp
        end
      }
    }
  }
}
