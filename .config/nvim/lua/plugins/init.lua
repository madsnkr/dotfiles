return {
  -- Themes
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd([[colorscheme tokyonight-moon]])
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

  -- Icons
  "nvim-tree/nvim-web-devicons",

  -- markdown live preview
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- Indentation lines
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
  },

  -- Better comments
  {
    "numToStr/Comment.nvim",
    config = true,
    keys = {
      { "gc", mode = { "n", "v" } }, { "gcc", mode = { "n", "v" } }, { "gbc", mode = { "n", "v" } }
    },
  },

  -- Hop words
  {
    "phaazon/hop.nvim",
    config = true,
    keys = {
      { "fw", "<cmd>HopWord<cr>", desc = "Hop Word" }
    }
  },

  -- git gui
  {
    "NeogitOrg/neogit",
    config = true,
    keys = {
      { "<leader>gs", "<cmd>Neogit<cr>", desc = "Status" }
    }
  },
  -- git decorations
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = true
  },

  -- vscode like winbar
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
  },

  -- note taking and documentation, etc
  {
    'lervag/wiki.vim',
    ft = { "markdown", "vimwiki" },
    keys = {
      { "<localleader>ww",              "<plug>(wiki-index)" },
      { "<localleader>wn",              "<plug>(wiki-open)" },
      { "<localleader>w<localleader>w", "<plug>(wiki-journal)" },
      { "<localleader>wx",              "<plug>(wiki-reload)" },
      { "<cr>",                         "<plug>(wiki-link-follow)" },
      { "<bs>",                         "<plug>(wiki-link-return)" },
      { "<localleader>wd",              "<plug>(wiki-page-delete)" },
      { "<localleader>wr",              "<plug>(wiki-page-rename)" },
      { "]l",                           "<plug>(wiki-link-next)" },
      { "[l",                           "<plug>(wiki-link-prev)" },
    },
    init = function()
      vim.g.wiki_mappings_use_defaults = "none" -- Dont use default mappings as they mess up existsing bindings
      vim.g.wiki_root = '~/Documents/wiki'
    end
  },
  {
    "luckasRanarison/nvim-devdocs",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>sd", "<cmd>DevdocsOpenCurrentFloat<cr>", desc = "Open Docs" }
    },
    cmd = {
      "DevdocsFetch",
      "DevdocsInstall",
      "DevdocsUninstall",
      "DevdocsOpen",
      "DevdocsOpenFloat",
      "DevdocsOpenCurrent",
      "DevdocsOpenCurrentFloat",
      "DevdocsUpdate",
      "DevdocsUpdateAll",
    },
    config = function()
      require("nvim-devdocs").setup {
        previewer_cmd = "glow",                         -- for example: "glow"
        cmd_args = { "-s", "dark", "-w", "80" },        -- example using glow: { "-s", "dark", "-w", "80" }
        picker_cmd = true,                              -- use cmd previewer in picker preview
        picker_cmd_args = { "-s", "dark", "-w", "50" }, -- example using glow: { "-s", "dark", "-w", "50" }
        after_open = function(bufnr)
          vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end
      }
    end
  }
}
