" ===============
" Setup-Agda
"
" Setup-Agda: 1. Add agda as a compatible filetype for syntax highlighting:
autocmd BufRead,BufNewFile *.agda,*.lagda set filetype=agda
au BufRead,BufNewFile *.agda setf agda
au BufRead,BufNewFile *.lagda setf lagda

" Setup-Agda:
    " 2. Output unicode syntax fixture
    " for the Agda Programming Language integration

" to4 -> toa -> \to arrow -> Logical Implication
autocmd FileType agda,lagda inoremap <Space>to4 →

" l4m -> lam -> \lambda -> Lambda Abstraction (binder)
autocmd FileType agda,lagda inoremap <Space>l4m λ

" s1g -> sig -> \sigma -> Dependent Sum
autocmd FileType agda,lagda inoremap <Space>s1g Σ

" p1 -> pi -> \pi -> Dependent Product
autocmd FileType agda,lagda inoremap <Space>p1 Π

" tu4 -> tua -> \turna -> Universal Quantification
autocmd FileType agda inoremap <Space>tu4 ∀

" ex1 -> exist -> Existential Quantification
autocmd FileType agda,lagda inoremap <Space>ex1 ∃

" equiv -> equivalence -> Bidirectional Implication
autocmd FileType agda,lagda inoremap <Space>equ ≡


" ===================
" markdown headers

:%s/^;, \[/#### ```;, \[/g | :g/;, \[/norm! A```/g
:g/```/```/g


