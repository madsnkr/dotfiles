return {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>",                                 { desc = "Find Files" } },
    { "<leader>fb", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "File Browser" } },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>",                                  { desc = "Grep" } },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>",                                  { desc = "Help Tags" } },
    { "<leader>fs", "<cmd>Telescope grep_string<CR>",                                { desc = "Grep string" } },
    { "<leader>fm", "<cmd>Telescope man_pages<CR>",                                  { desc = "Man Pages" } },
    { "<leader>fr", "<cmd>Telescope oldfiles<CR>",                                   { desc = "Recently used" } },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
          },
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
          previewer = false,
          hidden = true
        },
      },
      extensions = {
        file_browser = {
          theme = "ivy",
          initial_mode = "normal",
          quiet = true,
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
        },
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        }
      }
    }

    telescope.load_extension "fzf"
    telescope.load_extension "file_browser"

    -- Custom colors to make telescope look clean af
    local colors = require("catppuccin.palettes").get_palette()
    local TelescopeColor = {
      TelescopeMatching = { fg = colors.flamingo },
      TelescopeSelection = { fg = colors.text, bg = colors.surface, bold = true },
      TelescopePromptPrefix = { bg = colors.surface0 },
      TelescopePromptNormal = { bg = colors.surface0 },
      TelescopeResultsNormal = { bg = colors.mantle },
      TelescopePreviewNormal = { bg = colors.mantle },
      TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
      TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
      TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
      TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
      TelescopeResultsTitle = { fg = colors.mantle },
      TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
    }
    --Loop each hl group colors and set them globally
    for hl, col in pairs(TelescopeColor) do
      vim.api.nvim_set_hl(0, hl, col)
    end
  end
}
