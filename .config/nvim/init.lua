require("user.remap")
require("tools")
require("settings") -- user.set
require("user.packer")

vim.opt.runtimepath:prepend("~/.vim") -- counterpart of :set^=, prepend or add before all characters
vim.opt.runtimepath:append ("~/.vim/after") -- counterpart of :set+=, append or add after all characters
vim.o.packpath = vim.o.runtimepath
--require("~/.vimrc")

-- check ./lua/user/packer.lua for installed plugins

-- python interpreter path from virtualenv
vim.g.python3_host_prog = "p3hp_placeholder"

