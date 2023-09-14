return {
  -- Themes
  {
    "catppuccin/nvim",
    lazy = false,
    config = function()
      vim.cmd([[colorscheme catppuccin-mocha]])
    end
  },
  -- Make neovim transparent
  {
    "xiyaowong/transparent.nvim",
    cmd = { "TransparentEnable", "TransparentToggle" },
    keys = {
      { "<leader>te", "<cmd>TransparentEnable<cr>", desc = "Enable Transparency Mode" },
      { "<leader>tt", "<cmd>TransparentToggle<cr>", desc = "Toggle Transparency Mode" },
    },
    config = function()
      require("transparent").setup({
        extra_groups = { "Cursorline", "NormalFloat", "TelescopeSelection" },
      })
      require('transparent').clear_prefix('BufferLine')
    end
  },

  "nvim-tree/nvim-web-devicons",

  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" }
  },
  -- Better comments
  {
    "numToStr/Comment.nvim",
    config = true,
    keys = {
      { "gc", mode = { "n", "v" } }, { "gcc", mode = { "n", "v" } }, { "gbc", mode = { "n", "v" } }
    },
  },
  {
    "phaazon/hop.nvim",
    config = true,
    keys = {
      { "fw", "<cmd>HopWord<cr>", desc = "Hop Word" }
    }
  },
  {
    "NeogitOrg/neogit",
    config = true,
    keys = {
      { "<leader>gs", "<cmd>Neogit<cr>", desc = "Status" }
    }
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = true
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    event = "VeryLazy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      show_dirname = false,
      show_basename = false,
      -- show_modified = false,
      kinds = {
        File = " ",
        Module = " ",
        Namespace = " ",
        Package = " ",
        Class = " ",
        Method = " ",
        Property = " ",
        Field = " ",
        Constructor = " ",
        Enum = " ",
        Interface = " ",
        Function = " ",
        Variable = " ",
        Constant = " ",
        String = " ",
        Number = " ",
        Boolean = " ",
        Array = " ",
        Object = " ",
        Key = " ",
        Null = " ",
        EnumMember = " ",
        Struct = " ",
        Event = " ",
        Operator = " ",
        TypeParameter = " ",
      },
    },
    config = true,
  }
}
