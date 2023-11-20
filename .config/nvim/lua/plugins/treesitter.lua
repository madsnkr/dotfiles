return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects", -- Lets us edit inside scope of text objects
    "RRethy/nvim-treesitter-endwise",              -- Automatically add "end" to some languages
    --Auto close brackets, strings, parentheses
    { "windwp/nvim-autopairs",  event = "InsertEnter", opts = {} },
    { "windwp/nvim-ts-autotag", event = "InsertEnter" }, --Use treesitter to autoclose and autorename html tag
  },
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = {
      "bash",
      "lua",
      "html",
      "css",
      "javascript",
      "typescript",
      "vim",
      "yaml",
      "markdown",
      "json",
      "markdown_inline",
      "regex",
      "tsx",
    },
    -- false will disable the whole extension
    highlight = { enable = true },

    -- Enable indentation
    indent = { enable = true },

    -- Enable  "windwp/nvim-ts-autotag"
    autotag = { enable = true, enable_rename = true },

    -- vim-matchup
    matchup = { enable = true },

    endwise = { enable = true },

    -- nvim-treesitter-textobjects
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        }
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>xp"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>xP"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      }
    },
    lsp_interop = {
      enable = true,
      border = "none",
      floating_preview_opts = {},
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dc"] = "@class.outer",
      }
    }
  },
  config = function(_, opts)
    require "nvim-treesitter.configs".setup(opts)
  end
}
