-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    --{ import = "plugins.packerSpecs" },
    {
        'nvim-telescope/telescope.nvim',
        version = '0.1.8',
        -- or, branch = '0.1.x',
        dependencies = { {'nvim-lua/plenary.nvim'} }
    },


    --{ 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', },

    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
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

    -- lsp-zero
    {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v3.x',
      dependencies = {
        --- Uncomment these if you want to manage LSP servers from neovim
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},

        -- Autocompletion
        {
            'hrsh7th/nvim-cmp',
            event = 'InsertEnter',
            config = function()
                local cmp = require('cmp')

                cmp.setup({
                    sources = {
                        {name = 'nvim_lsp'},
                    },
                    mapping = cmp.mapping.preset.insert({
                        ['<C-space>'] = cmp.mapping.complete(),
                        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    }),
                    snippet = {
                        expand = function(args)
                            vim.snippet.expand(args.body)
                        end,
                    },
                })
            end
        },

        -- LSP Support
        {
            'neovim/nvim-lspconfig',
            cmd = "LspInfo",
            event = {'BufReadPre', 'BufNewFile'},
            dependencies = {
                -- Autocompletion
                {'hrsh7th/cmp-nvim-lsp'},
            },
            init = function ()
                local lsp_defaults = require('lspconfig').util.default_config

                -- add cmp_nvim_lsp capabilities settings to lspconfig
                -- this should be executed before you configure any language server
                lsp_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lsp_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
                )

                -- LspAttach is used to enable features when
                -- there is a language server active for the file
                vim.api.nvim_create_autocmd('LspAttach', {
                    desc = 'LSP actions',
                    callback = function (event)
                        local opts = {buffer = event.buf}

                        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                        vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

                    end,
                })

                --require('lspconfig').gleam.setup({})
                --require('lspconfig').ocamllsp.setup({})

            end
        },

        -- Snippets
        {'L3MON4D3/LuaSnip',lazy = true},

        },
    },

    {'julian/lean.nvim'},
    -- -- julian's lean.nvim LSP
    --  {
    --      'julian/lean.nvim',
    --      dependencies = {
    --          'VonHeikemen/lsp-zero.nvim',
    --          --'neovim/nvim-lspconfig',
    --          'nvim-lua/plenary.nvim',

    --          -- Autocompletion
    --          -- below already is being imported by
    --          -- lsp-zero dependency tree

    --          --'hrsh7th/nvim-cmp',
    --          --'hrsh7th/cmp-nvim-lsp',
    --          --'hrsh7th/cmp-buffer',
    --          --'hrsh7th/cmp-path',
    --      },
    --      opts = {
    --          mappings = true,
    --      }
    --  },


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



    -- NotebookNavigator for Python REPL
    {

        "GCBallesteros/NotebookNavigator.nvim",
        keys = {
            { "]h", function() require("notebook-navigator").move_cell "d" end },
            { "[h", function() require("notebook-navigator").move_cell "u" end },
            { "<leader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
            { "<leader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
        },
        dependencies = {
            "echasnovski/mini.comment",
            "hkupty/iron.nvim", -- repl provider
            -- "akinsho/toggleterm.nvim", -- alternative repl provider
            -- "benlubas/molten-nvim", -- alternative repl provider
            "anuvyklack/hydra.nvim",
        },
    event = "VeryLazy",
    config = function()
        local nn = require "notebook-navigator"
        nn.setup({
            cell_markers = {
            -- python = "# %%",
            },
            activate_hydra_keys = "<leader>h" ,
            show_hydra_hint = true,
            hydra_keys = {
                comment = "c",
                run = "X",
                run_and_move = "x",
                move_up = "k",
                move_down = "j",
                add_cell_before = "a",
                add_cell_after = "b",
            },
            repl_provider = "auto",
            syntax_highlight = false,
            cell_highlight_group = "Folded",
        })
    end,
    },
    --{
    --    config = function ()
    --        require("presence"):setup(){}
    --
    --    end
    --},

    -- nvim-platformio
    {
        'anurag3301/nvim-platformio.lua',
        dependencies = {
            {'akinsho/nvim-toggleterm.lua'},
            {'nvim-telescope/telescope.nvim'},
            {'nvim-lua/plenary.nvim'},
        },
    },


  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
