return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    defaults = {
      prefix = "<leader>",
      mode = { "n", "v" },
      w = { "<cmd>update!<cr>", "Save" },
      q = {
        name = "Quit",
        q = { "<cmd>q!<cr>", "Quit all" },
        ["<Tab>"] = { "<cmd>bd!<cr>", "Quit Buffer" }
      },
      g = { name = "+Git" },
      f = { name = "+Find" },
      d = { name = "+Debug" },
      t = { name = "+Transparency" },
      l = { name = "+Language" },
    }
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.register({ opts.defaults })
  end
}
