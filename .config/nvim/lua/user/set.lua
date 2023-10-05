-- basics

vim.o.nocompatible
vim.api.nvim_command('filetype plugin indent on')
vim.api.nvim_command('syntax on')
-- colorscheme x
vim.o.enconding = 'utf-8'
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
vim.o.backspace = ('indent','eol','start')
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
vim.cmd([[
autocmd
]])
-- others

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")




