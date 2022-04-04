local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  vim.notify("cmp_nvim_lsp not found")
end

local utils_ok, utils = pcall(require, 'user.lsp.ts-utils')
if not utils_ok then
  vim.notify('lsp.ts-utils not found')
end

M={}

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local function lsp_handle_client(client)
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
    if utils_ok then utils.on_attach() end
  end

  if client.name == 'jsonls' then
    client.resolved_capabilities.document_formatting = false
  end
end

M.on_attach = function(client, bufnr)
  lsp_handle_client(client)
  require('user.lsp.keymaps').lsp_keymaps(client, bufnr)
  lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

if not status_ok then
  return
end
M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
