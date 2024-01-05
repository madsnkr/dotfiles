return {
  'akinsho/bufferline.nvim',
  event = "VeryLazy",
  opts = {
    options = {
      separator_style = "thin",
      diagnostics = "nvim_lsp",
      show_tab_indicators = true,
      show_buffer_close_icons = false,
      show_buffer_close_icon = false,
    }
  },
  keys = {
    { "<Tab>n", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" } },
    { "<Tab>p", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" } },
    { "<Tab>g", "<cmd>BufferLinePick<cr>",      { desc = "Goto buffer" } },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
  end,
}
