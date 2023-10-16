-- basics

vim.o.nocompatible = 'true'
vim.api.nvim_command('filetype plugin indent on')
vim.api.nvim_command('syntax on')
-- colorscheme x
vim.o.encoding = 'utf-8'
vim.o.number = 'true'
vim.o.relativenumber = 'true'
vim.o.mouse = 'a'
vim.o.history = '1000'
vim.o.aw = 'true'
vim.o.ts = '4'
vim.o.nocp = 'true'
vim.o.nowrap = 'true'
vim.o.ruler = 'true'
vim.o.ve = 'all'
vim.o.vb = 'true'
vim.o.ic = 'true'
vim.o.ai = 'true'
vim.o.tabstop = '4'
vim.o.expandtab = 'true'
vim.o.shiftwidth = '4'
vim.o.softtabstop = '4'
vim.o.backspace = 'indent,eol,start'
vim.o.title = 'true'
vim.o.ttyfast = 'true'
vim.o.background = 'dark'

-- splits open bottom and right
vim.o.splitbelow = 'true'
vim.o.splitright = 'true'

-- shortcuts for split navigation

-- shorten function name
local keymap = vim.api.nvim_set_keymap

-- normal = n
-- visual = v
-- visual_block = x
-- insert = i
-- term_mode = t
-- command_mode = c

-- shortcuts for window split navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- interpret .md related files as .markdown
vim.opt.vimwiki_ext2syntax = {'.Rmd:markdown, .rmd:markdown,.md:markdown, .markdown:markdown, .mdown:markdown'}

-- calcurse notes
vim.api.nvim_create_autocmd({
    "BufRead, BufNewFile", "/tmp/calcurse*,~/.calcurse/notes/*",
"set filetype=markdown",
{augroup = "CalcurseFileType"}}
-- vim.opt.nvim_buf_set_option = markdown

-- spell-check set to F6
map
-- choose and open a url with urlview
noremap

-- copy selected text to system clipboard (requires xclip)
vnoremap

-- goyo plugin
map
inoremap

-- enable goyo by default for mutt writting
-- below, goyo width should be the line limit in mutt
vim.api.nvim_create_autocmd({
    "BufRead, BufNewFile", "/tmp/neomutt*",
    "vim.g.goyo_width=72",
    {augroup = "Goyo"}}

-- autocomplete
vim.g.wildmode = {longest,list,full}
vim.g.wildmenu =

-- delete all whitespace traling on save
vim.api.nvim_create_autocmd({
    "BufWritePre, *",
    "%s/\s\+$//e",
})

-- renew bash and ranger configs when shortcut files are updated
--


-- clean out text build files with a script whenever you close a .tex file
vim.api.nvim_create_autocmd({
    "VimLeave, *.tex",
    "!texclear",
})

-- disable automatic commenting on newline
-- filetype
vim.api.nvim_create_autocmd({
    "FileType, *",
    "setlocal",
    "formatoptions-=c, formatoptions-=r, formatoptions-=o",
})

-- create new tab with C-T (ctrl+t)
nnoremap

-- navigate between guides

vim.keymap.set('n', '<Space><Tab>', '<Esc>/<++><Enter>')
inoremap
vnoremap
map
inoremap

-- normal mode

-- snippets
-- others

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")





