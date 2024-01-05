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
      },
      g = { name = "+Git" },
      f = { name = "+Find" },
      d = { name = "+Debug" },
      t = { name = "+Transparency" },
      l = { name = "+Language" },
      s = {
        name = "+Search",
        c = { function() require("utils.cheats").cht() end, "CheatSheet" },
        s = { function() require("utils.cheats").stack_overflow() end, "StackOverflow" }
      }
    }
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.register({ opts.defaults })
  end
}
