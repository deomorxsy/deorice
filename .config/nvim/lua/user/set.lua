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
{augroup = "CalcurseFileType"}})
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
vim.api.nvim_create_autocmd({
    "BufRead,BufNewFile", "/tmp/neomutt*",
    "vim.g.goyo_width=72",
    {augroup = "Goyo"}})

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
vim.api.nvim_set_keymap('n', '<C-t>', ':tabnew<CR>', { noremap = true })

-- navigate between guides
-- vim.api.nvim_set_keymap('n', '<Space><Tab>', '<Esc>/<++><Enter>')
vim.keymap.set('n', '<Space><Tab>', '<Esc>/<++><Enter>')
vim.api.nvim_set_keymap('i', '<Space><Tab>', [[<Esc>/<++><CR>"_c4l]], {})
vim.api.nvim_set_keymap('v', '<Space><Tab>', [[<Esc>/<++><CR>"_c4l]], {})
vim.api.nvim_set_keymap('n', '<Space><Tab>', [[<Esc>/<++><CR>"_c4l]], {})
vim.api.nvim_set_keymap('i', ';gui', '<++>', {})

-- normal mode
vim.api.nvim_set_keymap('i', 'jw', '<Esc>')
vim.api.nvim_set_keymap('i', 'wj', '<Esc>')


 --____        _                  _
--/ ___| _ __ (_)_ __  _ __   ___| |_ ___
--\___ \| '_ \| | '_ \| '_ \ / _ \ __/ __|
 --___) | | | | | |_) | |_) |  __/ |_\__ \
--|____/|_| |_|_| .__/| .__/ \___|\__|___/
              --|_|   |_|

autocmd('Filetype', {
    group = 'wordCount',
    pattern = {'tex'},
    command = ''
})


-- snippets


-- others

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")




