-- or just format it from a bash heredoc and redirect after.
vim.g.python3_host_prog = os.getenv("HOME") .. '/.config/nvim/venv_nvim/neovim3/bin/python3'

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
        prefix = '■',
        spacing = 2,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

vim.g.vimtex_compiler_latexmk = vim.tbl_deep_extend("force",
    vim.g.vimtex_compiler_latexmk or {},
    {
        aux_dir = "aux",
        out_dir = "output",
        executable = "latexmk",
        options = {
            "-pdf",
            "-interaction=nostopmode",
            "-file-line-error",
            "-shell-escape",
        },
    }
)


