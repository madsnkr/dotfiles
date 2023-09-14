return {
  "mfussenegger/nvim-dap",
  dependencies = { "rcarriga/nvim-dap-ui" },
  config = function()
    local mason_registry = require("mason-registry")
    local codelldb = mason_registry.get_package("codelldb")
    local extension_path = codelldb:get_install_path() .. "/extension/"
    local codelldb_path = extension_path .. "adapter/codelldb"
    local liblldb_path = extension_path .. "lldb/lib/liblldb.so"


    local dap, dapui = require("dap"), require("dapui")

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

    dapui.setup()

    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = "Error" })

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Keymaps
    vim.keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<cr>")
    vim.keymap.set("n", "<leader>dt", "<cmd>DapTerminate<cr>")
    vim.keymap.set("n", "<leader>do", "<cmd>DapStepOver<cr>")
    vim.keymap.set("n", "<leader>dc", "<cmd>DapContinue<cr>")
    vim.keymap.set("n", "<leader>di", "<cmd>DapStepInto<cr>")
    vim.keymap.set({ "n", "v" }, "<leader>dh",
      function() require("dap.ui.widgets").hover("<cexpr>", { border = "none" }) end)
    vim.keymap.set({ 'n', 'v' }, '<leader>dp', function()
      require('dap.ui.widgets').preview()
    end)
  end
}
