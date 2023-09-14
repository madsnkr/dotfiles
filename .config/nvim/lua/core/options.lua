local indent = 2

vim.g.mapleader = " " -- Map <leader>
vim.g.maplocalleader = ","

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true }) --Do nothing when pressing space in normal or visual

vim.opt.termguicolors = true                                        -- Enable 24 bit colors in terminal
vim.opt.hlsearch = true                                             -- Highlight on search
vim.opt.number = true                                               -- Set line numbers
vim.opt.relativenumber = true                                       -- Set relative line numbers
vim.opt.mouse = "a"                                                 -- Enable mouse in all modes
vim.opt.undofile = true                                             -- Save undo history
vim.opt.ignorecase = true                                           -- Case insensitive search
vim.opt.smartcase = true                                            -- Enable overriding the ignore case if captial letter
vim.opt.clipboard = "unnamedplus"                                   -- Access system clipboard

vim.opt.expandtab = true                                            -- Use spaces instead of tabs
vim.opt.shiftwidth = indent                                         -- Number of spaces a level of indentation is worth
vim.opt.tabstop = indent                                            -- Number of spaces TAB char is worth
vim.opt.shiftround = true                                           -- Round indent to multiple of shiftwidth
vim.opt.breakindent = true

vim.opt.path:remove "/usr/include"
vim.opt.path:append "**"

vim.opt.wildignore =
"**/node_modules/*,*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx" -- Patterns to ignore when tab completing
vim.opt.wildignorecase = true                                                     -- Ignore case when searching in wild menu

vim.opt.timeoutlen = 300                                                          -- Time in ms to wait for a mapped sequence to complete
vim.opt.updatetime = 200                                                          -- After this many ms and nothing is typed, swap file is written to disk


vim.opt.foldcolumn = "1"    -- Display 1 column for folding
vim.opt.foldlevel = 99      -- 0 = close all folds 99 = no folds closed
vim.opt.foldlevelstart = -1 -- 0 = start with all folds closed 99 = no closed folds
vim.opt.foldenable = true

vim.opt.signcolumn =
"yes"                      -- Always show sign column aka the little bar on left of line number
vim.opt.scrolloff = 8      -- 8 minimum lines above and below cursor
vim.opt.cursorline = true  -- Add line at cursor
