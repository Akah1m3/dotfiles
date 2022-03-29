local settings = { 
  backup = false,
  cmdheight = 2,                           -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,  -- so that `` is visible in markdown files,
  fileencoding = "utf-8",
  mouse = "a",
  pumheight = 10,
  -- showmode = false,
  showtabline = 2,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  termguicolors = true,
  timeoutlen = 1000, -- time to mapped sequence to complete,
  undofile = true,
  updatetime = 300, -- faster completion 4000ms default,
  writebackup = false,
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  cursorline = true,
  number = true,
  relativenumber = true,
  signcolumn = "yes",
  wrap = false,
  scrolloff = 8,
  sidescrolloff = 8,
  autoread = true,
  -- guifont = "Roboto",
  langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz',
}

for k, v in pairs(settings) do
  vim.opt[k] = v
end
