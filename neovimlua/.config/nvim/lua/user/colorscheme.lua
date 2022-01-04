vim.cmd [[
try
  set background=dark
  colorscheme darkplus 
  colorscheme grovbox 
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
