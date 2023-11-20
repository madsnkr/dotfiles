local M = {}

function M.capabilities()
  -- LSP folding
  local capabilities = vim.lsp.protocol.make_client_capabilities() -- Gets a new ClientCapabilities object describing the LSP client capabilities
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  return require("cmp_nvim_lsp").default_capabilities(capabilities) -- For cmp-nvim-lsp
end

function M.format(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    -- Create autocommand event handler
    vim.api.nvim_create_autocmd("BufWritePre", {
      -- Create autocommand group
      group = vim.api.nvim_create_augroup("Format", { clear = true }), -- Clear existing commands if the group already exists
      buffer = bufnr,                                                  -- Buffer number for buffer-local autocommands
      callback = function() vim.lsp.buf.format({ async = false }) end
    })
  end
end

function M.keymaps(client, buffer)
  M.keymap({ "n", "v" }, "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover" })

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

function M.on_attach(callback)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      callback(client, bufnr)
    end,
  })
end

return M
