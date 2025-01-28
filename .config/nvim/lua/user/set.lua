--  ____                                                 _             _
-- |  _ \  ___  ___  _ __ ___   ___  _ ____  _____ _   _( )___  __   _(_)_ __ ___  _ __ ___
-- | | | |/ _ \/ _ \| '_ ` _ \ / _ \| '__\ \/ / __| | | |// __| \ \ / / | '_ ` _ \| '__/ __|
-- | |_| |  __/ (_) | | | | | | (_) | |   >  <\__ \ |_| | \__ \  \ V /| | | | | | | | | (__
-- |____/ \___|\___/|_| |_| |_|\___/|_|  /_/\_\___/\__, | |___/   \_/ |_|_| |_| |_|_|  \___|
--                                                 |___/


-- basics

vim.o.signcolumn = 'no' -- used by coc.nvim
--vim.o.nocompatible = true
vim.api.nvim_command('filetype plugin indent on')
vim.api.nvim_command('syntax on')
-- colorscheme x
vim.o.encoding = 'utf-8'
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.history = 1000
vim.o.aw = true
vim.o.ts = 4
--vim.o.nocp = true
vim.wo.wrap = false
vim.o.ruler = true
vim.o.ve = 'all'
vim.o.vb = true
vim.o.ic = true
vim.o.ai = true
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.backspace = 'indent,eol,start'
vim.o.title = true
vim.o.ttyfast = true
vim.o.background = 'dark'

-- splits open bottom and right
vim.o.splitbelow = true
vim.o.splitright = true

-- shortcuts for split navigation

-- shorten function name
local keymap = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }
-- normal = n
-- visual = v
-- visual_block = x
-- insert = i
-- term_mode = t
-- command_mode = c

-- shortcuts for window split navigation
keymap("n", "<C-h>", "<C-w>h", opt)
keymap("n", "<C-j>", "<C-w>j", opt)
keymap("n", "<C-k>", "<C-w>k", opt)
keymap("n", "<C-l>", "<C-w>l", opt)

-- interpret .md related files as .markdown
vim.g.vimwiki_ext2syntax = {'.Rmd:markdown, .rmd:markdown,.md:markdown, .markdown:markdown, .mdown:markdown'}

-- calcurse notes
--vim.api.nvim_create_autocmd({
--    "BufRead, BufNewFile", "/tmp/calcurse*,~/.calcurse/notes/*",
--"set filetype=markdown",
--{augroup = "CalcurseFileType"}})

-- vim.opt.nvim_buf_set_option = markdown

-- spell-check set to F6
vim.api.nvim_set_keymap('n', '<F6>', '<cmd>setlocal spell! spelllang=en_us,es<CR>', {})

-- choose and open a url with urlview
vim.api.nvim_set_keymap('n', '<leader>u', ':w<Home>silent <End> !urlview<CR>', {})

-- copy selected text to system clipboard (requires xclip)
vim.api.nvim_set_keymap('v', '<C-c>', [["cy<esc>:!echo -n '<C-R>c' | xclip<CR>]], {noremap = true, silent = true})

-- goyo plugin
vim.api.nvim_set_keymap('n', '<F10>', ':Goyo<CR>', {})
vim.api.nvim_set_keymap('i', '<F10>', '<esc>:Goyo<CR>>a', {})

-- enable goyo by default for mutt writting
-- below, goyo width should be the line limit in mutt
--vim.api.nvim_create_autocmd({ 'BufRead','BufNewFile' }, {"/tmp/neomutt*", "vim.g.goyo_width=72"})

--- 'vim.api.nvim_create_autocmd({
---    { 'BufRead,BufNewFile', '/tmp/neomutt*', 'vim.g.goyo_width=72' },
---    {pattern={'Goyo'}}
---})

-- autocomplete
vim.g.wildmode = {longest,list,full}
vim.g.wildmenu =

-- delete all whitespace traling on save
vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '',
        command = ':%s/\\s\\+$//e'
    })

-- renew bash and ranger configs when shortcut files are updated
--


-- clean out text build files with a script whenever you close a .tex file
vim.api.nvim_create_autocmd('VimLeave', {
    pattern = '*.tex',
    command = "!texclear",
})

-- disable automatic commenting on newline
-- filetype
vim.api.nvim_create_autocmd('FileType', {
    pattern = "*",
    command = "setlocal formatoptions-=c, formatoptions-=r, formatoptions-=o",
})

-- create new tab with C-T (ctrl+t)
vim.api.nvim_set_keymap('n', '<C-t>', ':tabnew<CR>', { noremap = true })

-- navigate between guides
-- vim.api.nvim_set_keymap('n', '<Space><Tab>', '<Esc>/<++><Enter>')
vim.keymap.set('n', '<Space><Tab>', '<Esc>/<++><Enter>')
vim.api.nvim_set_keymap('i', '<Space><Tab>', [[<Esc>/<++><CR>"_c4l]], {})
vim.api.nvim_set_keymap('v', '<Space><Tab>', [[<Esc>/<++><CR>"_c4l]], {})
vim.api.nvim_set_keymap('n', '<Space><Tab>', [[<Esc>/<++><CR>"_c4l]], {})
vim.api.nvim_set_keymap('i', ';gui', '<++>', {})

-- normal mode
vim.api.nvim_set_keymap('i', 'jw', '<Esc>', {})
vim.api.nvim_set_keymap('i', 'wj', '<Esc>', {})


 --____        _                  _
--/ ___| _ __ (_)_ __  _ __   ___| |_ ___
--\___ \| '_ \| | '_ \| '_ \ / _ \ __/ __|
 --___) | | | | | |_) | |_) |  __/ |_\__ \
--|____/|_| |_|_| .__/| .__/ \___|\__|___/
              --|_|   |_|
-- snippets

-- LATEX

---- word count


local augroup_tex = vim.api.nvim_create_augroup('tex_snippets', { clear = true})
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'word count with detex piping to wc -w',
    command = 'inoremap <F3> <Esc>:w !detex "\"| wc -w <CR>'
})

-- compile document with xelatex
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'compile with xelatex',
    command = 'inoremap <F5> <Esc>:!xelatex<space><c-r>%<Enter>a'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'compile with xelatex',
    command = 'nnoremap <F5> :!xelatex<space><c-r>%<Enter>'
})

---- code snippets
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'yet another latex snippet',
    command = ';fr "\"begin{frame}<Enter>"\"frametitle{}<Enter><Enter><++><Enter><Enter>"\"end{frame}<Enter><Enter><++><Esc>6kf}i'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'yet another latex snippet',
    command = 'inoremap ;fi "\"begin{fitch}<Enter><Enter>"\"end{fitch}<Enter><Enter><++><Esc>3kA '
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'yet another latex snippet',
    command = 'inoremap ;exe "\"begin{exe}<Enter>"\"ex<Space><Enter>"\"end{exe}<Enter><Enter><++><Esc>3kA '
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;em "\"emph{}<++><Esc>T{i'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;bf \textbf{}<++><Esc>T{i'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'vnoremap ; <ESC>`<i"\"{<ESC>`>2la}<ESC>?"\\"{<Enter>a'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;it \textit{}<++><Esc>T{i'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;ct \textcite{}<++><Esc>T{i'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;cp "\"parencite{}<++><Esc>T{i'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;glos {\"gll<Space><++><Space>\"\\<Enter><++><Space>\"\\<Enter>\"\"trans{``<++>\'\'}<Esc>2k2bcw'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;x "\"begin{xlist}<Enter>"\"ex<Space><Enter>"\"end{xlist}<Esc>kA<Space>'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;ol "\"begin{enumerate}<Enter><Enter>"\"end{enumerate}<Enter><Enter><++><Esc>3kA"\"item<Space>'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;ul "\"begin{itemize}<Enter><Enter>"\"end{itemize}<Enter><Enter><++><Esc>3kA"\"item<Space>'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;li <Enter>"\"item<Space>'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;ref "\"ref{}<Space><++><Esc>T{i'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;tab "\"begin{tabular}<Enter><++><Enter>"\"end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;ot'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = '"\"begin{tableau}<Enter>"\"inp{<++>}<Tab>"\"const{<++>}<Tab><++><Enter><++><Enter>"\"end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;can "\"cand{}<Tab><++><Esc>T{i'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;con "\"const{}<Tab><++><Esc>T{i'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;v \vio{}<Tab><++><Esc>T{i'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;a "\"href{}{<++>}<Space><++><Esc>2T{i'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;sc "\"textsc{}<Space><++><Esc>T{i'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;chap "\"chapter{}<Enter><Enter><++><Esc>2kf}i'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;sec "\"section{}<Enter><Enter><++><Esc>2kf}i'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;ssec "\"subsection{}<Enter><Enter><++><Esc>2kf}i'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;sssec "\"subsubsection{}<Enter><Enter><++><Esc>2kf}i'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;st <Esc>F{i*<Esc>f}i'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;beg "\"begin{DELRN}<Enter><++><Enter>"\"end{DELRN}<Enter><Enter><++><Esc>4k0fR:MultipleCursorsFind<Space>})DELRN<Enter>c'
})
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;up <Esc>/usepackage<Enter>o"\"usepackage{}<Esc>i'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'nnoremap ;up /usepackage<Enter>o"\"usepackage{}<Esc>i'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;tt "\"texttt{}<Space><++><Esc>T{i'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;bt {"\"blindtext}'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;nu $"\"varnothing$'
    })
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command =  'inoremap ;col'
    })

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = '"\"begin{columns}[T]<Enter>"\"begin{column}{.5"\"textwidth}<Enter><Enter>"\"end{column}<Enter>"\"begin{column}{.5"\"textwid'
    })

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'th}<Enter><++><Enter>"\"end{column}<Enter>"\"end{columns}<Esc>5kA'
    })

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = '',
    command = 'inoremap ;rn ("\"ref{})<++><Esc>F}i '
    })

--- LATEX Logical symbols
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'LaTeX logical symbols',
    command = 'inoremap ;m $$<Space><++><Esc>2T$i'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'LaTeX logical symbols',
    command = 'inoremap ;M $$$$<Enter><Enter><++><Esc>2k$hi'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'LaTeX logical symbols',
    command = 'inoremap ;neg {\neg}'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'LaTeX logical symbols',
    command = 'inoremap ;V {\vee}'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'LaTeX logical symbols',
    command = 'inoremap ;or {\vee}'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'LaTeX logical symbols',
    command = 'inoremap ;L {"\"wedge}'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'LaTeX logical symbols',
    command = 'inoremap ;and {"\"wedge}'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'LaTeX logical symbols',
    command = 'inoremap ;ra {\rightarrow}'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'LaTeX logical symbols',
    command = 'inoremap ;la {"\"leftarrow}'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'LaTeX logical symbols',
    command = 'inoremap ;lra {"\"leftrightarrow}'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'LaTeX logical symbols',
    command = 'inoremap ;fa {\forall}'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'LaTeX logical symbols',
    command = 'inoremap ;ex {"\"exists}'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'LaTeX logical symbols',
    command = 'inoremap ;dia {"\"Diamond}'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'LaTeX logical symbols',
    command = 'inoremap ;box {"\"Box}'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'LaTeX logical symbols',
    command = 'inoremap ;gt {\textgreater}'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'LaTeX logical symbols',
    command = 'inoremap ;lt{"\"textless}'
})



--- LaTeX Linguistics Shortcuts
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'latex linguistics shortcuts',
    command = 'noremap ;nom {"\"textsc{nom}}'})
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'latex linguistics shortcuts',
    command = 'inoremap ;acc {"\"textsc{acc}}'
})
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'latex linguistics shortcuts',
    command = 'inoremap ;dat {"\"textsc{dat}}'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'latex linguistics shortcuts',
    command = 'inoremap ;gen {"\"textsc{gen}}'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'latex linguistics shortcuts',
    command = 'inoremap ;abl {"\"textsc{abl}}'})
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'latex linguistics shortcuts',
    command = 'inoremap ;voc {"\"textsc{voc}}'
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'latex linguistics shortcuts',
    command = 'inoremap ;loc {"\"textsc{loc}}'
})
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'latex linguistics shortcuts',
    command = 'inoremap ;inst {"\"textsc{inst}}'})
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'tex'},
    group = augroup_tex,
    desc = 'latex linguistics shortcuts',
    command = 'inoremap ;tipa "\"textipa{}<Space><++><Esc>T{i'})




---- PHP/HTML
local augroup_php_html = vim.api.nvim_create_augroup('tex_snippets', { clear = true})

local php_html = vim.cmd([[
  augroup augroup_php_html
    inoremap ;b <b></b><Space><++><Esc>FbT>i
    inoremap ;i <em></em><Space><++><Esc>FeT>i
    inoremap ;h1 <h1></h1><Enter><Enter><++><Esc>2kf<i
    inoremap ;h2 <h2></h2><Enter><Enter><++><Esc>2kf<i
    inoremap ;h3 <h3></h3><Enter><Enter><++><Esc>2kf<i
    inoremap ;p <p></p><Enter><Enter><++><Esc>02kf>a
    inoremap ;a <a<Space>href=""><++></a><Space><++><Esc>14hi
    inoremap ;e <a<Space>target="_blank"<Space>href=""><++></a><Space><++><Esc>14hi
    inoremap ;ul <ul><Enter><li></li><Enter></ul><Enter><Enter><++><Esc>03kf<i
    inoremap ;li <Esc>o<li></li><Esc>F>a
    inoremap ;ol <ol><Enter><li></li><Enter></ol><Enter><Enter><++><Esc>03kf<i
    inoremap ;im <table<Space>class="image"><Enter><caption align="bottom"></caption><Enter><tr><td><a<space>href="pix/<++>"><img<Space>src="pix/<++>"<Space>width="<++>"></a></td></tr><Enter></table><Enter><Enter><++><Esc>4kf>a
    inoremap ;td <td></td><++><Esc>Fdcit
    inoremap ;tr <tr></tr><Enter><++><Esc>kf<i
    inoremap ;th <th></th><++><Esc>Fhcit
    inoremap ;tab <table><Enter></table><Esc>O
    inoremap ;gr <font color="green"></font><Esc>F>a
    inoremap ;rd <font color="red"></font><Esc>F>a
    inoremap ;yl <font color="yellow"></font><Esc>F>a
    inoremap ;dt <dt></dt><Enter><dd><++></dd><Enter><++><esc>2kcit
    inoremap ;dl <dl><Enter><Enter></dl><enter><enter><++><esc>3kcc
  augroup END
]])
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'php', 'html'},
    group = augroup_php_html,
    desc = 'php/html snippets',
    command = php_html
})

-- others

--- vimtex
vim.g.vimtex_view_method = 'zathura'
-- vim.g.tex_flavor = 'xelatex'
-- vim.g.Tex_IgnoredWarnings = 'Underfull'."\n".

--- .bib
local augroup_texbib = vim.api.nvim_create_augroup('tex_bib', { clear = true})

local bibtex = [[
    inoremap ;a @article{<Enter>author<Space>=<Space>"<++>",<Enter>year<Space>=<Space>"<++>",<Enter>title<Space>=<Space>"<++>",<Enter>journal<Space>=<Space>"<++>",<Enter>volume<Space>=<Space>"<++>",<Enter>pages<Space>=<Space>"<++>",<Enter>}<Enter><++><Esc>8kA,<Esc>i |
    inoremap ;b @book{<Enter>author<Space>=<Space>"<++>",<Enter>year<Space>=<Space>"<++>",<Enter>title<Space>=<Space>"<++>",<Enter>publisher<Space>=<Space>"<++>",<Enter>}<Enter><++><Esc>6kA,<Esc>i |
    inoremap ;c @incollection{<Enter>author<Space>=<Space>"<++>",<Enter>title<Space>=<Space>"<++>",<Enter>booktitle<Space>=<Space>"<++>",<Enter>editor<Space>=<Space>"<++>",<Enter>year<Space>=<Space>"<++>",<Enter>publisher<Space>=<Space>"<++>",<Enter>}<Enter><++><Esc>8kA,<Esc>i

]]

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'bib'},
    group = augroup_texbib,
    desc = 'tex bib files',
	command = bibtex
})


--- MARKDOWN
local augroup_md = vim.api.nvim_create_augroup('au_md', { clear = true})

local md_cmds = [[
    map <leader>w yiWi[<esc>Ea](<esc>pa) |
    inoremap ;n ---<Enter><Enter> |
    inoremap ;b ****<++><Esc>F*hi |
    inoremap ;s ~~~~<++><Esc>F~hi |
    inoremap ;e **<++><Esc>F*i |
    inoremap ;h ====<Space><++><Esc>F=hi |
    inoremap ;i ![](<++>)<++><Esc>F[a |
    inoremap ;a [](<++>)<++><Esc>F[a |
    inoremap ;1 #<Space><Enter><++><Esc>kA |
    inoremap ;2 ##<Space><Enter><++><Esc>kA |
    inoremap ;3 ###<Space><Enter><++><Esc>kA |
    inoremap ;l --------<Enter> |
    <F5> :!pandoc<space><C-r>%<space>-o<space><C-r>%.pdf<Enter><Enter> |
    <F5> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter> |
    ;r ```{r}<CR>```<CR><CR><esc>2kO |
    ;p ```{python}<CR>```<CR><CR><esc>2kO |
    nnoremap <F5> :!echo "require(rmarkdown); render('<c-r">"%') "\"| R --vanilla |
    inoremap ;r ```{r}<CR>```<CR><CR><esc>2kO
]]

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'rmd'},
    group = augroup_md,
    desc = 'tex bib files',
	command = md_cmds
})

--- xml

local xml_cmds = [[
    inoremap ;a <a href="\<++>"><++></a><++><Esc>F"ci"
    vmap <expr> ++ VMATH_YankAndAnalyse()
    nmap ++ vip++
    vnoremap K xkP`[V`]
    vnoremap J xp`[V`]
    vnoremap L >gv
    vnoremap H <gv
]]

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'rmd'},
    group = augroup_texbib,
    desc = 'tex bib files',
	command = xml_cmds
})
--- others others
--vim.o.pastetoggle = '<F2>'

-- Nvim-R configs (Lua port)

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('Rsettings', { clear = true })

autocmd('Filetype', {
    group = 'Rsettings',
    pattern = {'r'},
    callback = function()
        vim.bo.filetype = 'r'
        vim.o.R_app = 'R'
        vim.o.R_cmd = 'R --vanilla'
        vim.o.R_esc_term = 0
    end,
})

--vim.o.R_app = 'R'
--vim.o.R_cmd = 'R --vanilla'
--vim.o.R_esc_term = 0

-- function test

local myFunction()
    print("Hello from myFunction!")

--write
local writer = [[
    fu! Writer()
    map <silent> <Up> gk
    imap <silent> <Up> <C-o>gk
    map <silent> <Down> gj
    imap <silent> <Down> <C-o>gj
    map <silent> <home> g<home>
    imap <silent> <home> <C-o>g<home>
    map <silent> <End> g<End>
    imap <silent> <End> <C-o>g<End>
    "setlocal
    set wrap
    set linebreak
    set nolist
    set display+=lastline
    endfunction
]]

vim.api.nvim_exec2(writer, { output = true })

-- ncm2 completion requirements
vim.g.python3_host_prog = "$HOME/.config/nvim/venv_nvim/neovim3/bin/python"

-- Statusline
-- refer to user/newstatus.lua

-- nvim-R tmux
vim.g.R_source = '~/.config/vim/tmux_split.vim'

-- laters gators
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- autocomplete popup

--local ag_pmenu = vim.api.nvim_create_augroup('ag_pmenu', { clear = true})

--local pmenu_colors = [[
--    highlight hl-Pmenu ctermfg=white ctermbg=black guifg=white guibg=black |
--    highlight hl-PmenuSel ctermfg=black ctermbg=white guifg=black guibg=white
--]]

--vim.api.nvim_create_autocmd('FileType', {
--    group = ag_pmenu,
--    desc = 'pmenu colors',
--	command = pmenu_colors
--})
--
--vim.cmd[[
--    'au VimEnter * highlight hl-Pmenu ctermfg=white ctermbg=black' |
--    'au VimEnter * highlight hl-PmenuSel ctermfg=green ctermbg=black'
--]]
--
--
vim.cmd[[
    highlight Pmenu      ctermfg=2 ctermbg=3 guifg=#778ba5 guibg=#1c1c1c
    highlight PmenuSel   ctermfg=2 ctermbg=3 guifg=yellow guibg=#8a8a8c
    highlight PmenuSbar  ctermfg=2 ctermbg=3 guifg=#778ba5 guibg=#1c1c1c
    highlight PmenuThumb ctermfg=2 ctermbg=3 guifg=#778ba5 guibg=#1c1c1c
]]

-- floating diagnostics
--
vim.keymap.set('n', '<leader>i', function()
    local found_float = false
    for _, flowin in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_config(flowin).relative ~= '' then
            vim.api.nvim_win_close(flowin, true)
            found_float = true
        end
    end

    if found_float then
        return
    end

    vim.diagnostic.open_float(nil, { focus = false, scope = 'cursor' })
end, {desc = 'toggle diagnostics'})
