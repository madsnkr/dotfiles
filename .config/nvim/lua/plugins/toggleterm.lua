return {
  "akinsho/toggleterm.nvim",
  cmd = { "ToggleTerm" },
  keys = { { [[<C-\>]] } },
  opts = {
    direction = "float",
    persist_size = true,
    open_mapping = [[<C-\>]],
    float_opts = {
      border = "shadow",
      width = 100,
      height = 20
    }
  },
}
