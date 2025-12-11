-- recognize global config
-- vim.lsp.start({
--     name = 'lua-language-server',
--     cmd = { 'lua-language-server' },
--     root_dir = vim.fs.dirname(vim.fs.find({'.git', '.vim', 'nvim'}, { upward = true })[1]),
--     settings = { Lua = { diagnostics = { globals = {'vim'} } } },
-- })

-- or just format it from a bash heredoc and redirect after.
-- _G.vim = require("vim")
vim.g.python3_host_prog = os.getenv("HOME") .. "/.config/nvim/venv_nvim/neovim3/bin/python3"

-- add LazyVim to the global scope for treesitter
-- lua-language-server annotation syntax: https://github.com/LuaLS/lua-language-server/wiki/Annotations
-- lazyvim global syntax: https://github.com/LazyVim/LazyVim/blob/c64a61734fc9d45470a72603395c02137802bc6f/lua/lazyvim/config/init.lua#L1
-- _G.LazyVim = require("lazyvim.util")
-- _G.LazyVim = require("lazyvim")

-- bootstrap lazy.nvim, LazyVim and custom plugins
require("config.lazy")

require("user.remap")
require("tools")
require("settings") -- user.set
--require("user.packer")
--require("plugins.packerSpecs") -- Ensure the plugins are loaded.

-- configure treesitter

-- configure virtual text diagnostics
vim.diagnostic.config({
	virtual_text = {
		prefix = "■",
		spacing = 2,
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

vim.g.vimtex_compiler_latexmk = vim.tbl_deep_extend("force", vim.g.vimtex_compiler_latexmk or {}, {
	aux_dir = "aux",
	out_dir = "output",
	executable = "latexmk",
	options = {
		"-pdf",
		"-interaction=nostopmode",
		"-file-line-error",
		"-shell-escape",
	},
})

--require("luarc")
