local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  vim.notify("lsp_installer not found")
	return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
      allow_incremental_sync = true
    }
	}

  local ok, _opts = pcall(require, "user.lsp.settings." .. server.name)
  if ok then
    opts = vim.tbl_deep_extend("force", _opts, opts)
  end
  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end)
