local M = {}
function M.setup(client, buffer)
  if client.name == "rust_analyzer" then
    M.keymap({ "n", "v" }, "K", require("rust-tools").hover_actions.hover_actions, { desc = "Hover" })
    M.keymap("n", "<localleader>rr", "<cmd>RustRunnables<CR>", { desc = "Run" })
    M.keymap("n", "<localleader>rc", "<cmd>RustOpenCargo<CR>", { desc = "Open Cargo.toml" })
  else
    M.keymap({ "n", "v" }, "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover" })
  end

  M.keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "Prev Diagnostic" })
  M.keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "Next Diagnostic" })
  M.keymap("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>",
    { desc = "Prev Error" })
  M.keymap("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>",
    { desc = "Next Error" })

  M.keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename" })
  M.keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code Action" })
  M.keymap("n", "<leader>ld", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Line Diagnostic" })
  M.keymap("n", "<leader>li", "<cmd>LspInfo<CR>", { desc = "Lsp Info" })

  -- Add keymap for formatting if possible
  if client.server_capabilities.documentFormattingProvider then
    M.keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", { desc = "Format Document" })
  end

  M.keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Goto Definition" })
  M.keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "Goto Declaration" })
  M.keymap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature Help" })
  M.keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Goto Implementation" })
  M.keymap("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { desc = "Goto Type Definition" })
end

function M.keymap(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true, buffer = true, }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

return M
