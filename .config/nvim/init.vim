command! Scratch lua require'tools'.fromScratch

lua << EOF
  local nvim_lsp = require 'nvim_lsp'
  nvim_lsp.rust_analyzer.setup({})
EOF
