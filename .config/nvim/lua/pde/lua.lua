if not require("config").pdenv.lua then
  return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "lua", "luadoc", "luap" })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "stylua" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" } -- Fixes 'undefined global `vim`'
              },
              workspace = {
                checkThirdParty = false,
              },
              completion = { callSnippet = "Replace" },
              telemetry = { enable = false },
              hint = {
                enable = false,
              },
            },
          },
        },
      },
      setup = {
        lua_ls = function(_, _)
          local utils = require "plugins.lsp.utils"
          utils.on_attach(function(client, buffer)
          end)
        end,
      },
    },
  }
}
