local keymap = vim.keymap.set
local default_opts = { noremap = true, silent = true }

-- Personal bindings --
-- Back to normal mode when using "jk"
keymap("i", "jk", "<ESC>", default_opts)

-- Better line navigation when lines wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Center search results
keymap("n", "n", "nzz", default_opts)
keymap("n", "N", "Nzz", default_opts)

keymap("n", "g,", "g,zvzz", default_opts)
keymap("n", "g;", "g;zvzz", default_opts)

-- Prevents exit from visual when indenting
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)

-- Cancel search highlight
keymap("n", "<ESC>", "<cmd>noh<CR>", default_opts)


-- Move Lines/Selected blocks
keymap("n", "<C-A-j>", ":m .+1<CR>==", default_opts)
keymap("v", "<C-A-j>", ":m '>+1<CR>gv=gv", default_opts)
keymap("i", "<C-A-j>", "<Esc>:m .+1<CR>==gi", default_opts)
keymap("n", "<C-A-k>", ":m .-2<CR>==", default_opts)
keymap("v", "<C-A-k>", ":m '<-2<CR>gv=gv", default_opts)
keymap("i", "<C-A-k>", "<Esc>:m .-2<CR>==gi", default_opts)

-- Resize windows
keymap("n", "<Left>", ":vertical resize +1<CR>", default_opts)
keymap("n", "<Right>", ":vertical resize -1<CR>", default_opts)
keymap("n", "<Up>", ":horizontal resize -1<CR>", default_opts)
keymap("n", "<Down>", ":horizontal resize +1<CR>", default_opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', default_opts)

-- Add semicolon to end of current line
keymap("n", "<leader>;", "A;<ESC>", default_opts)

-- Auto indent on insert
keymap("n", "i", function()
  if #vim.fn.getline "." == 0 then -- IF current line is empty
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true })
