return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = require("plugins.alpha.logo")["random"]
    dashboard.section.buttons.val = {
      dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"), -- Edit new file and start insert
      dashboard.button("f", "󰈞  Find Files", ":Telescope find_files<CR>"), -- Find files
      dashboard.button("r", "  Recently used", ":Telescope oldfiles<CR>"), -- Recently used files
      dashboard.button("b", "󰥨  File Browser", ":Telescope file_browser<CR>"), -- File browser
      dashboard.button("g", "󱎸  Live grep", ":Telescope live_grep<CR>"), -- Live grep
      dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"), -- Go to init.lua
      dashboard.button("l", "󰾆  Lazy", ":Lazy <CR>"), -- Go to init.lua
      dashboard.button("q", "󰅚  Quit NVIM", ":qa<CR>"), -- Quit neovim
    }

    -- Highlights
    dashboard.section.footer.opts.hl = "Constant"
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Function"
    dashboard.section.buttons.opts.hl_shortcut = "Type"


    if vim.o.filetype == "lazy" then
      -- close and re-open Lazy after showing alpha
      vim.notify("Missing plugins installed!", vim.log.levels.INFO, { title = "lazy.nvim" })
      vim.cmd.close()
      require("alpha").setup(dashboard.opts)
      require("lazy").show()
    else
      require("alpha").setup(dashboard.opts)
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

        local version = "   v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
        local fortune = require "alpha.fortune"
        local quote = table.concat(fortune(), "\n")
        local plugins = "⚡Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
        local footer = "\t" .. version .. "\t" .. plugins .. "\n" .. quote

        dashboard.section.footer.val = footer
        pcall(vim.cmd.AlphaRedraw)
      end
    })
  end
}
