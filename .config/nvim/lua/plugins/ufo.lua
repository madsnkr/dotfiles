return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  keys = {
    { "zc" },
    { "zo" },
    { "zC" },
    { "zO" },
    { "za" },
    { "zA" },
    { "zR", function() require("ufo").openAllFolds() end, desc = "Open All Folds" },
    { "zM", function() require("ufo").closeAllFolds() end, desc = "Close All Folds" },
    { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Open Folds Except Kinds" },
    { "zm", function() require("ufo").closeFoldsWith() end, desc = "Close Folds With" },
  },
  config = function()
    require("ufo").setup {
      provider_selector = function(bufnr, filetype, buftype) 
        return { "lsp", "indent" }
      end
    }
  end
}
