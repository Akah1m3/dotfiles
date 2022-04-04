local utils_ok, _ = pcall(require, "nvim-lsp-ts-utils")
if not utils_ok then
  vim.notify("ts_utils not found")
	return
end

M={}

M.telescope_qf = function()
  local ok, telescope = pcall (require, 'telescope.builtin')
  if ok then
    vim.diagnostic.setqflist{ open = false, severity = require'user.lsp.setup'.severity }
    telescope.quickfix()
  end
end

M.prev_diagnostics = function ()
  vim.diagnostic.goto_prev { border = "rounded", severity = require"user.lsp.setup".severity }
end

M.next_diagnostics = function ()
  vim.diagnostic.goto_next { border = "rounded", severity = require"user.lsp.setup".severity }
end

M.show_message = function ()
  vim.diagnostic.open_float{ "line", severity = { min = vim.diagnostic.severity.HINT } }
end

M.lsp_keymaps = function(client, bufnr)
  local keymap = vim.api.nvim_buf_set_keymap
  local opts = { noremap = true, silent = false }
  keymap(bufnr, "n", "<leader>fp", "<cmd>lua require'user.lsp.keymaps'.telescope_qf()<cr>", opts)
  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap(bufnr, "n", "gl", '<cmd>lua require"user.lsp.keymaps".show_message()<CR>', opts)
  keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  -- keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap( bufnr, "n", "<leader>lh", '<cmd>lua require"user.lsp.keymaps".prev_diagnostics()<CR>', opts)
  keymap( bufnr, "n", "<leader>ll", '<cmd>lua require"user.lsp.keymaps".next_diagnostics()<CR>', opts)
  keymap( bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  keymap( bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)

  if utils_ok and client.name == 'tsserver' then
    keymap(bufnr, "n", "<Leader>lo", ":TSLspOrganize<CR>", opts)
    keymap(bufnr, "n", "<Leader>lI", ":TSLspImportAll<CR>", opts)
    keymap(bufnr, "n", "<Leader>li", ":TSLspImportCurrent<CR>", opts)
    keymap(bufnr, "n", "<Leader>lR", ":TSLspRenameFile<CR>", opts)
  end
end

return M
