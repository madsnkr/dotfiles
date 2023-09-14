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
