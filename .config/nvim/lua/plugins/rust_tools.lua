return {
  "simrat39/rust-tools.nvim",
  opts = {
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
        -- overrideCommand = "cargo clippy",
      }
    }
  },
  config = function(_, opts)
    local mason_registry = require("mason-registry")
    local codelldb = mason_registry.get_package("codelldb")
    local extension_path = codelldb:get_install_path() .. "/extension/"
    local codelldb_path = extension_path .. "adapter/codelldb"
    local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

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
      server = {
        settings = opts
      }
    }
  end
}
