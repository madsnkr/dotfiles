return {
  'akinsho/bufferline.nvim',
  event = "VeryLazy",
  opts = {
    options = {
      separator_style = "slant" or "padded_slant",
      diagnostics = "nvim_lsp",
      show_tab_indicators = true,
      show_buffer_close_icons = false,
      show_buffer_close_icon = false
    }
  },
  keys = {
    { "<Tab>",   "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" } },
    { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" } },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
  end,
}
