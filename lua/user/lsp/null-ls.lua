local status_ok, null_ls = pcall(require, 'null-ls')
if not status_ok then
  vim.notify("null-ls not found in lsp")
  return
end

null_ls.setup({
  sources = {
      null_ls.builtins.formatting.prettierd.with({only_local = 'node_modules/.bin'}),
      null_ls.builtins.diagnostics.eslint_d.with({only_local = 'node_modules/.bin'}),
      null_ls.builtins.code_actions.eslint_d.with({only_local = 'node_modules/.bin'}),
      null_ls.builtins.diagnostics.eslint.with({only_local = 'node_modules/.bin'}),
      null_ls.builtins.code_actions.eslint.with({only_local = 'node_modules/.bin'}),
      null_ls.builtins.formatting.prettier.with({only_local = 'node_modules/.bin'}),
  },
  debug = false,
  -- Format on save
  on_attach = function(client)
      if client.resolved_capabilities.document_formatting then
          vim.cmd([[
          augroup LspFormatting
              autocmd! * <buffer>
              autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
          augroup END
          ]])
      end
  end,
})
