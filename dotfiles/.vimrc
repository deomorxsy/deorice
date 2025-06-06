"  ____                                                 _             _
" |  _ \  ___  ___  _ __ ___   ___  _ ____  _____ _   _( )___  __   _(_)_ __ ___  _ __ ___
" | | | |/ _ \/ _ \| '_ ` _ \ / _ \| '__\ \/ / __| | | |// __| \ \ / / | '_ ` _ \| '__/ __|
" | |_| |  __/ (_) | | | | | | (_) | |   >  <\__ \ |_| | \__ \  \ V /| | | | | | | | | (__
" |____/ \___|\___/|_| |_| |_|\___/|_|  /_/\_\___/\__, | |___/   \_/ |_|_| |_| |_|_|  \___|
"                                                 |___/

" [old] Load Pathogen for plugins:
"	execute pathogen#infect()
"	execute pathogen#helptags()

" Some basics:
	set nocompatible
	filetype plugin on
	syntax on
    "colorscheme wal
	set encoding=utf-8
	set number
	set relativenumber
	set mouse=a
	set history=1000
	set aw
	set ts=4
	set nocp
	set nowrap
	set ruler
	set ve=all
	set vb
	set ic
	set ai
	set tabstop=4
	set expandtab
	set shiftwidth=4
	set softtabstop=4
	set backspace=indent,eol,start
	set title
	set ttyfast
	set background=dark
	syntax on

	execute pathogen#infect()
	syntax on
	filetype plugin indent on

" Splits open at the bottom and right
	set splitbelow
	set splitright

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Open my bibliography file in split
	map <F9> :vsp<space>~/Documents/LaTeX/uni.bib<CR>

" Open the selected text in a split (i.e. should be a file).
	map <leader>o "oyaW:sp <C-R>o<CR>
	xnoremap <leader>o "oy<esc>:sp <C-R>o<CR>
	vnoremap <leader>o "oy<esc>:sp <C-R>o<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

"For saving view folds:
	"au BufWinLeave * mkview
	"au BufWinEnter * silent loadview

" Interpret .md files, etc. as .markdown
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" Make calcurse notes markdown compatible:
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown

" Spell-check set to F6:
	map <F6> :setlocal spell! spelllang=en_us,es<CR>

" Use urlview to choose and open a url:
	:noremap <leader>u :w<Home>silent <End> !urlview<CR>

" Copy selected text to system clipboard (requires xclip installed):
	vnoremap <C-c> "cy<esc>:!echo -n '<C-R>c' \|<space>xclip<CR><enter>

" Goyo plugin makes text more readable when writing prose:
	map <F10> :Goyo<CR>
	inoremap <F10> <esc>:Goyo<CR>a

" Enable Goyo by default for mutt writting
	" Goyo's width will be the line limit in mutt.
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=72
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo

" Enable autocompletion:
	set wildmode=longest,list,full
	set wildmenu

" Automatically deletes all tralling whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated, renew bash and ranger configs with new
" material:
	autocmd BufWritePost ~/.scripts/folders,~/.scripts/configs !bash ~/.scripts/shortcuts.sh

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear

" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" C-T for new tab
	nnoremap <C-t> :tabnew<cr>

" Navigating with guides
	inoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
	vnoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
	map <Space><Tab> <Esc>/<++><Enter>"_c4l
	inoremap ;gui <++>

" For normal mode when in terminals (in X I have caps mapped to esc, this replaces it when I don't have X)
	inoremap jw <Esc>
	inoremap wj <Esc>


 "____        _                  _
"/ ___| _ __ (_)_ __  _ __   ___| |_ ___
"\___ \| '_ \| | '_ \| '_ \ / _ \ __/ __|
 "___) | | | | | |_) | |_) |  __/ |_\__ \
"|____/|_| |_|_| .__/| .__/ \___|\__|___/
              "|_|   |_|

"""LATEX
	" Word count:
	autocmd FileType tex map <F3> :w !detex \| wc -w<CR>
	autocmd FileType tex inoremap <F3> <Esc>:w !detex \| wc -w<CR>
	" Compile document using xelatex:
	autocmd FileType tex inoremap <F5> <Esc>:!xelatex<space><c-r>%<Enter>a
	autocmd FileType tex nnoremap <F5> :!xelatex<space><c-r>%<Enter>
	" Code snippets
	autocmd FileType tex inoremap ;fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
	autocmd FileType tex inoremap ;fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><Esc>3kA
	autocmd FileType tex inoremap ;exe \begin{exe}<Enter>\ex<Space><Enter>\end{exe}<Enter><Enter><++><Esc>3kA
	autocmd FileType tex inoremap ;em \emph{}<++><Esc>T{i
	autocmd FileType tex inoremap ;bf \textbf{}<++><Esc>T{i
	autocmd FileType tex vnoremap ; <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
	autocmd FileType tex inoremap ;it \textit{}<++><Esc>T{i
	autocmd FileType tex inoremap ;ct \textcite{}<++><Esc>T{i
	autocmd FileType tex inoremap ;cp \parencite{}<++><Esc>T{i
	autocmd FileType tex inoremap ;glos {\gll<Space><++><Space>\\<Enter><++><Space>\\<Enter>\trans{``<++>''}}<Esc>2k2bcw
	autocmd FileType tex inoremap ;x \begin{xlist}<Enter>\ex<Space><Enter>\end{xlist}<Esc>kA<Space>
	autocmd FileType tex inoremap ;ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
	autocmd FileType tex inoremap ;ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
	autocmd FileType tex inoremap ;li <Enter>\item<Space>
	autocmd FileType tex inoremap ;ref \ref{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ;tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
	autocmd FileType tex inoremap ;ot \begin{tableau}<Enter>\inp{<++>}<Tab>\const{<++>}<Tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i
	autocmd FileType tex inoremap ;can \cand{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ;con \const{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ;v \vio{}<Tab><++><Esc>T{i
	autocmd FileType tex inoremap ;a \href{}{<++>}<Space><++><Esc>2T{i
	autocmd FileType tex inoremap ;sc \textsc{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ;chap \chapter{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ;sec \section{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ;ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ;sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
	autocmd FileType tex inoremap ;st <Esc>F{i*<Esc>f}i
	autocmd FileType tex inoremap ;beg \begin{DELRN}<Enter><++><Enter>\end{DELRN}<Enter><Enter><++><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<Enter>c
	autocmd FileType tex inoremap ;up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
	autocmd FileType tex nnoremap ;up /usepackage<Enter>o\usepackage{}<Esc>i
	autocmd FileType tex inoremap ;tt \texttt{}<Space><++><Esc>T{i
	autocmd FileType tex inoremap ;bt {\blindtext}
	autocmd FileType tex inoremap ;nu $\varnothing$
	autocmd FileType tex inoremap ;col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
	autocmd FileType tex inoremap ;rn (\ref{})<++><Esc>F}i

"""LATEX Logical symbols
	autocmd FileType tex inoremap ;m $$<Space><++><Esc>2T$i
	autocmd FileType tex inoremap ;M $$$$<Enter><Enter><++><Esc>2k$hi
	autocmd FileType tex inoremap ;neg {\neg}
	autocmd FileType tex inoremap ;V {\vee}
	autocmd FileType tex inoremap ;or {\vee}
	autocmd FileType tex inoremap ;L {\wedge}
	autocmd FileType tex inoremap ;and {\wedge}
	autocmd FileType tex inoremap ;ra {\rightarrow}
	autocmd FileType tex inoremap ;la {\leftarrow}
	autocmd FileType tex inoremap ;lra {\leftrightarrow}
	autocmd FileType tex inoremap ;fa {\forall}
	autocmd FileType tex inoremap ;ex {\exists}
	autocmd FileType tex inoremap ;dia	{\Diamond}
	autocmd FileType tex inoremap ;box	{\Box}
	autocmd FileType tex inoremap ;gt	{\textgreater}
	autocmd FileType tex inoremap ;lt	{\textless}
"""LaTeX Linguistics Shortcuts
	autocmd Filetype tex inoremap ;nom {\textsc{nom}}
	autocmd FileType tex inoremap ;acc {\textsc{acc}}
	autocmd FileType tex inoremap ;dat {\textsc{dat}}
	autocmd FileType tex inoremap ;gen {\textsc{gen}}
	autocmd FileType tex inoremap ;abl {\textsc{abl}}
	autocmd FileType tex inoremap ;voc {\textsc{voc}}
	autocmd FileType tex inoremap ;loc {\textsc{loc}}
	autocmd Filetype tex inoremap ;inst {\textsc{inst}}
	autocmd FileType tex inoremap ;tipa \textipa{}<Space><++><Esc>T{i

"""PHP/HTML
	autocmd FileType php,html inoremap ;b <b></b><Space><++><Esc>FbT>i
	autocmd FileType php,html inoremap ;i <em></em><Space><++><Esc>FeT>i
	autocmd FileType php,html inoremap ;h1 <h1></h1><Enter><Enter><++><Esc>2kf<i
	autocmd FileType php,html inoremap ;h2 <h2></h2><Enter><Enter><++><Esc>2kf<i
	autocmd FileType php,html inoremap ;h3 <h3></h3><Enter><Enter><++><Esc>2kf<i
	autocmd FileType php,html inoremap ;p <p></p><Enter><Enter><++><Esc>02kf>a
	autocmd FileType php,html inoremap ;a <a<Space>href=""><++></a><Space><++><Esc>14hi
	autocmd FileType php,html inoremap ;e <a<Space>target="_blank"<Space>href=""><++></a><Space><++><Esc>14hi
	autocmd FileType php,html inoremap ;ul <ul><Enter><li></li><Enter></ul><Enter><Enter><++><Esc>03kf<i
	autocmd FileType php,html inoremap ;li <Esc>o<li></li><Esc>F>a
	autocmd FileType php,html inoremap ;ol <ol><Enter><li></li><Enter></ol><Enter><Enter><++><Esc>03kf<i
	autocmd FileType php,html inoremap ;im <table<Space>class="image"><Enter><caption align="bottom"></caption><Enter><tr><td><a<space>href="pix/<++>"><img<Space>src="pix/<++>"<Space>width="<++>"></a></td></tr><Enter></table><Enter><Enter><++><Esc>4kf>a
	autocmd FileType php,html inoremap ;td <td></td><++><Esc>Fdcit
	autocmd FileType php,html inoremap ;tr <tr></tr><Enter><++><Esc>kf<i
	autocmd FileType php,html inoremap ;th <th></th><++><Esc>Fhcit
	autocmd FileType php,html inoremap ;tab <table><Enter></table><Esc>O
	autocmd FileType php,html inoremap ;gr <font color="green"></font><Esc>F>a
	autocmd FileType php,html inoremap ;rd <font color="red"></font><Esc>F>a
	autocmd FileType php,html inoremap ;yl <font color="yellow"></font><Esc>F>a
	autocmd FileType php,html inoremap ;dt <dt></dt><Enter><dd><++></dd><Enter><++><esc>2kcit
	autocmd FileType php,html inoremap ;dl <dl><Enter><Enter></dl><enter><enter><++><esc>3kcc
	"autocmd FileType php,html inoremap -- &ndash;
	"autocmd FileType php,html inoremap --- &mdash;

""" vimtex

	let g:vimtex_view_method = 'zathura'
    """let g:tex_flavor = 'xelatex'
    """let g:Tex_IgnoredWarnings = 'Underfull'."\n".


""".bib
	autocmd FileType bib inoremap ;a @article{<Enter>author<Space>=<Space>"<++>",<Enter>year<Space>=<Space>"<++>",<Enter>title<Space>=<Space>"<++>",<Enter>journal<Space>=<Space>"<++>",<Enter>volume<Space>=<Space>"<++>",<Enter>pages<Space>=<Space>"<++>",<Enter>}<Enter><++><Esc>8kA,<Esc>i
	autocmd FileType bib inoremap ;b @book{<Enter>author<Space>=<Space>"<++>",<Enter>year<Space>=<Space>"<++>",<Enter>title<Space>=<Space>"<++>",<Enter>publisher<Space>=<Space>"<++>",<Enter>}<Enter><++><Esc>6kA,<Esc>i
	autocmd FileType bib inoremap ;c @incollection{<Enter>author<Space>=<Space>"<++>",<Enter>title<Space>=<Space>"<++>",<Enter>booktitle<Space>=<Space>"<++>",<Enter>editor<Space>=<Space>"<++>",<Enter>year<Space>=<Space>"<++>",<Enter>publisher<Space>=<Space>"<++>",<Enter>}<Enter><++><Esc>8kA,<Esc>i

"MARKDOWN
	autocmd Filetype markdown,rmd map <leader>w yiWi[<esc>Ea](<esc>pa)
	autocmd Filetype markdown,rmd inoremap ;n ---<Enter><Enter>
	autocmd Filetype markdown,rmd inoremap ;b ****<++><Esc>F*hi
	autocmd Filetype markdown,rmd inoremap ;s ~~~~<++><Esc>F~hi
	autocmd Filetype markdown,rmd inoremap ;e **<++><Esc>F*i
	autocmd Filetype markdown,rmd inoremap ;h ====<Space><++><Esc>F=hi
	autocmd Filetype markdown,rmd inoremap ;i ![](<++>)<++><Esc>F[a
	autocmd Filetype markdown,rmd inoremap ;a [](<++>)<++><Esc>F[a
	autocmd Filetype markdown,rmd inoremap ;1 #<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ;2 ##<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ;3 ###<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ;l --------<Enter>
	autocmd Filetype markdown map <F5> :!pandoc<space><C-r>%<space>-o<space><C-r>%.pdf<Enter><Enter>
	autocmd Filetype rmd map <F5> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>
	autocmd Filetype rmd inoremap ;r ```{r}<CR>```<CR><CR><esc>2kO
	autocmd Filetype rmd inoremap ;p ```{python}<CR>```<CR><CR><esc>2kO

""".xml
	"autocmd FileType xml inoremap ;e <item><Enter><title><++></title><Enter><pubDate><Esc>:put<Space>=strftime('%c')<Enter>A</pubDate><Enter><link><++></link><Enter><description><++></description><Enter></item>
	autocmd FileType xml inoremap ;e <item><Enter><title><++></title><Enter><pubDate><Esc>:put<Space>=strftime('%c')<Enter>A</pubDate><Enter><link><++></link><Enter><description><![CDATA[<++>]]></description><Enter></item><Esc>5kcit
	autocmd FileType xml inoremap ;a <a href="<++>"><++></a><++><Esc>F"ci"

	vmap <expr> ++ VMATH_YankAndAnalyse()
	nmap ++ vip++

	vnoremap K xkP`[V`]
	vnoremap J xp`[V`]
	vnoremap L >gv
	vnoremap H <gv

"set paste
set pastetoggle=<F2>

"""ncm2

    " enable ncm2 for all buffers
    "uncomment_to_activate autocmd BufEnter * call ncm2#enable_for_buffer()

    " IMPORTANT: :help Ncm2PopupOpen for more information
    "uncomment_to_activate autocmd set completeopt=noinsert,menuone,noselect

    " NOTE: you need to install completion sources to get completions. Check
    " our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki


"""ncm2 Optional Vimrc Tips

    " suppress the annoying 'match x of y', 'The only match' and 'Pattern not
    " found' messages
    "uncomment_to_activate autocmd set shortmess+=c

    " CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
    "uncomment_to_activate autocmd inoremap <c-c> <ESC>

    " When the <Enter> key is pressed while the popup menu is visible, it only
    " hides the menu. Use this mapping to close the menu and also start a new
    " line.
    "uncomment_to_activate autocmd inoremap <expr> <CR> (pumvisible() ? \"\<c-y>\<cr>" : \"\<CR>")

    " Use <TAB> to select the popup menu:
    "uncomment_to_activate autocmd inoremap <expr> <Tab> pumvisible() ? \"\<C-n>" : \"\<Tab>"
    "uncomment_to_activate autocmd inoremap <expr> <S-Tab> pumvisible() ? \"\<C-p>" : \"\<S-Tab>"

    " wrap existing omnifunc
    " Note that omnifunc does not run in background and may probably block the
    " editor. If you don't want to be blocked by omnifunc too often, you could
    " add 180ms delay before the omni wrapper:
    "  'on_complete': ['ncm2#on_complete#delay', 180,
    "               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
    "au User Ncm2Plugin call ncm2#register_source({
    "        \ 'name' : 'css',
    "        \ 'priority': 9,
    "        \ 'subscope_enable': 1,
    "        \ 'scope': ['css','scss'],
    "        \ 'mark': 'css',
    "        \ 'word_pattern': '[\w\-]+',
    "        \ 'complete_pattern': ':\s*',
    "        \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
    "        \ })

""" Nvim-R configs
let R_app = 'R'
let R_cmd = 'R --vanilla'
    "let R_path = '/opt/apache-spark/bin/load-spark-env.sh'
    """/opt/apache-spark/bin/spark-submit \"sparkr-shell" /tmp/directory/backend_port
    """ Nvim-R's R buffer
        """more info in: https://raw.githubusercontent.com/jalvesaq/Nvim-R/master/doc/Nvim-R.txt , search for 'terminal mode'
        let R_esc_term = 0

"" old function for SparkR
""function SparkR(what)
    "let g:rplugin_R = a:what
    "call StartR("R")
"endfunction
"nmap <silent> <F6> :call SparkR("R")<CR>
"nmap <silent> <F7> :call SparkR("sparkR")<CR>

"""vimsence options
"""let g:vimsence_custom_icons = {'r': 'Rlogo.png'}

""" Writting
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


"""ncm2 completion requirements
let g:python3_host_prog="/usr/bin/python3"


"" statusline
set laststatus=2
set statusline=                          " left align
set statusline+=%2*\                     " blank char
set statusline+=%2*\%{StatuslineMode()}
set statusline+=%2*\
set statusline+=%1*\ <<
set statusline+=%1*\ %f                  " short filename
set statusline+=%1*\ >>
set statusline+=%=                       " right align
set statusline+=%*
set statusline+=%3*\%h%m%r               " file flags (help, read-only, modified)
set statusline+=%4*\%{b:gitbranch}       " include git branch
set statusline+=%3*\%.25F                " long filename (trimmed to 25 chars)
set statusline+=%3*\::
set statusline+=%3*\%l/%L\\|             " line count
set statusline+=%3*\%y                   " file type
hi User1 ctermbg=black ctermfg=grey guibg=black guifg=grey
hi User2 ctermbg=green ctermfg=black guibg=green guifg=black
hi User3 ctermbg=black ctermfg=lightgreen guibg=black guifg=lightgreen

"" statusline functions
function! StatuslineMode()
    let l:mode=mode()
    if l:mode==#"n"
        return "NORMAL"
    elseif l:mode==?"v"
        return "VISUAL"
    elseif l:mode==#"i"
        return "INSERT"
    elseif l:mode==#"R"
        return "REPLACE"
    endif
endfunction

function! StatuslineGitBranch()
  let b:gitbranch=""
  if &modifiable
    lcd %:p:h
    let l:gitrevparse=system("git rev-parse --abbrev-ref HEAD")
    lcd -
    if l:gitrevparse!~"fatal: not a git repository"
      let b:gitbranch="(".substitute(l:gitrevparse, '\n', '', 'g').") "
    endif
  endif
endfunction

augroup GetGitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END

" nvim-R integration with tmux
"let R_external_term = 1
"let R_external_term =
"let R_notmuxconf = 1
let R_source = '~/.config/vim/tmux_split.vim'

