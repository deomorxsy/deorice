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
-- vim.g.mapleader = " " -- space
vim.g.mapleader = ","
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


    -- "=====> ncm-R for Rscripts completion
    -- { 'ncm2/ncm2' },
    -- { 'roxma/nvim-yarp' },
    -- { 'jalvesaq/Nvim-R' },
    -- { 'gaalcaras/ncm-R' },

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

    {
    },

    -- Code cell running, setup otter
    {
        "quarto-dev/quarto-nvim",
        dependencies = {
          "jmbuhr/otter.nvim",
          "nvim-treesitter/nvim-treesitter",
        },
    },

    -- LSP features in markdown cells
    {
        'jmbuhr/otter.nvim',
        dependencies = {
          'nvim-treesitter/nvim-treesitter',
        },
        opts = {},
    },

    -- Notebook conversion
    {
        "GCBallesteros/jupytext.nvim",
        lazy = false,
        opts = {
            -- on-disk representation
            style = "markdown"
        },
        config = true,
    },

    -- Image rendering (ueberzug backend)
    {
        "3rd/image.nvim",
        build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
        opts = {
            processor = "magick_cli",
        }
    },
    -- Run cells interactively
    {
        "benlubas/molten-nvim",
        version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        init = function()
            -- these are examples, not defaults. Please see the readme
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_output_win_max_height = 20
        end,
    },


    -- {
    --     "dccsillag/magma-nvim",
    --     build = ":UpdateRemotePlugins",
    --     config = function()
    --         vim.cmd("let g:magma_automatically_open_output = v:false")
    --         vim.keymap.set("n", "<leader>r", ":MagmaEvaluateOperator<CR>", { silent = true })
    --         vim.keymap.set("n", "<leader>rr", ":MagmaEvaluateLine<CR>", { silent = true })
    --         vim.keymap.set("x", "<leader>r", ":<C-u>MagmaEvaluateVisual<CR>", { silent = true })
    --         vim.keymap.set("n", "<leader>rc", ":MagmaReevaluateCell<CR>", { silent = true })
    --         vim.keymap.set("n", "<leader>rd", ":MagmaDelete<CR>", { silent = true })
    --         vim.keymap.set("n", "<leader>ro", ":MagmaShowOutput<CR>", { silent = true })
    --     end
    -- },


    {
        "nvimtools/hydra.nvim",
        config = function ()
            local Hydra = require("hydra")
            Hydra({
            -- create hydras
            name = "tiamat",
            mode = "n",
            body = "<leader>o",
            hint = [[
                _h_: <- _l_: -> _q_: exit
            ]],
            config = {
                -- see :h hydra-heads
                exit = false, -- set the default exit value for each head in the hydra

                -- decides what to do when a key which doesn't belong to any head is pressed
                --   nil: hydra exits and foreign key behaves normally, as if the hydra wasn't active
                --   "warn": hydra stays active, issues a warning and doesn't run the foreign key
                --   "run": hydra stays active, runs the foreign key
                foreign_keys = nil,

                -- see `:h hydra-colors`
                color = "red", -- "red" | "amaranth" | "teal" | "pink"

                -- define a hydra for the given buffer, pass `true` for current buf
                buffer = nil,

                -- when true, summon the hydra after pressing only the `body` keys. Normally a head is
                -- required
                invoke_on_body = true,

                -- description used for the body keymap when `invoke_on_body` is true
                desc = nil, -- when nil, "[Hydra] .. name" is used

                -- see :h hydra-hooks
                on_enter = nil, -- called when the hydra is activated
                on_exit = nil, -- called before the hydra is deactivated
                on_key = nil, -- called after every hydra head

                -- timeout after which the hydra is automatically disabled. Calling any head
                -- will refresh the timeout
                --   true: timeout set to value of 'timeoutlen' (:h 'timeoutlen')
                --   5000: set to desired number of milliseconds
                timeout = false, -- by default hydras wait forever

                -- see :h hydra-hint-hint-configuration
                hint =  {
                    position = "bottom",
                    border = "rounded",
                },
            },
            heads = {
                { "h", "<C-w>h", { desc = "Window left" } },
                { "l", "<C-w>l", { desc = "Window right" } },
                {"q", nil, { exit = true, desc = "Quit Hydra"} },
            }
        })
        end
    },
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
            --"anuvyklack/hydra.nvim",
        },
        event = "VeryLazy",
        config = function()
            local nn = require "notebook-navigator"
            nn.setup({
                cell_markers = {
                -- python = "# %%",
                },
                -- activate_hydra_keys = "<leader>h" ,
                -- show_hydra_hint = true,
                -- hydra_keys = {
                --     comment = "c",
                --     run = "X",
                --     run_and_move = "x",
                --     move_up = "k",
                --     move_down = "j",
                --     add_cell_before = "a",
                --     add_cell_after = "b",
                -- },
                repl_provider = "auto",
                syntax_highlight = false,
                cell_highlight_group = "Folded",
            })
        end,
    },



  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  -- notify is relative to the messages at startup.
  checker = {
      enabled = true,
      notify = false,
  },
})
