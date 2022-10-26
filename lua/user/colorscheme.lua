vim.cmd([[
try
  colorscheme catppuccin_macchiato
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]])
