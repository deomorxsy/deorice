return {
-- import your plugins
    --{ import = "plugins.packerSpecs" },
    {
        'nvim-telescope/telescope.nvim',
        version = '0.1.8',
        -- or, branch = '0.1.x',
        dependencies = { {'nvim-lua/plenary.nvim'} }
    },


    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', },
    { 'mbbill/undotree' },
    { 'ms-jpq/coq_nvim', branch = 'coq' },

    -- 9000+ Snippets
    { 'ms-jpq/coq.artifacts', branch = 'artifacts'},

    -- " lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
    -- " Need to **configure separately**
    { 'ms-jpq/coq.thirdparty', branch = '3p' },
    -- " - shell repl
    -- " - nvim lua api
    -- " - scientific calculator
    -- " - comment banner
    -- " - etc


    -- "=====> https://github.com/andweeb/presence.nvim
    -- { 'andweeb/presence.nvim' }

    {
        "andweeb/presence.nvim",
        config = function()
            require("presence"):setup({
            -- General options
            auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
            neovim_image_text   = ":ZZ", -- Text displayed when hovered over the Neovim image
            main_image          = "neovim",                   -- Main image display (either "neovim" or "file")
            client_id           = "793271441293967371",       -- Use your own Discord application client id (not recommended)
            log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
            debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
            enable_line_number  = false,                      -- Displays the current line number instead of the current project
            blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
            buttons             = true,                       -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
            file_assets         = {},                         -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
            show_time           = true,                       -- Show the timer

            -- Rich Presence text options
            editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
            file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
            git_commit_text     = "Committing changes",       -- Format string rendered when committing changes in git (either string or function(filename: string): string)
            plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
            reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
            workspace_text      = "Working on %s",            -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
            line_number_text    = "Line %s out of %s",        -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
        })
        end,
    },


    -- "=====> ncm-R for Rscripts completion
    { 'ncm2/ncm2' },
    { 'roxma/nvim-yarp' },
    { 'jalvesaq/Nvim-R' },
    { 'gaalcaras/ncm-R' },


    -- "====> rust-analyzer dependencies

    -- " Use release branch (recommend)
    -- use ('neoclide/coc.nvim', {branch = 'master'})
    -- " Or build from source code by using yarn: https://yarnpkg.com
    -- use ('neoclide/coc.nvim', {
    --     branch = 'master',
    --     run = 'yarn install --frozen-lockfile'
    -- })

    -- " nvim-jdtls
    { 'mfussenegger/nvim-jdtls' },



    -- " Vim 8 only
    -- uncomment on vim.init
    -- if !has('nvim')
    --     use ('roxma/vim-hug-neovim-rpc')
    --  endif

    -- Optional: for snippet support
    -- Further configuration might be required, read below
    { 'sirver/UltiSnips' },
    { 'ncm2/ncm2-ultisnips' },

    -- " Optional: better Rnoweb support (LaTeX completion)
    { 'lervag/vimtex' },

    -- lsp-zero
    {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v3.x',
      dependencies = {
        --- Uncomment these if you want to manage LSP servers from neovim
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},

        -- LSP Support
        {'neovim/nvim-lspconfig'},

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'L3MON4D3/LuaSnip'},

        },
    },

    -- nvim-platformio
    {
        'anurag3301/nvim-platformio.lua',
        dependencies = {
            {'akinsho/nvim-toggleterm.lua'},
            {'nvim-telescope/telescope.nvim'},
            {'nvim-lua/plenary.nvim'},
        },
    }

}
