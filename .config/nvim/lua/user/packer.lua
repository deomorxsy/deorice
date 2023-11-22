-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.3',
        -- or, branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    --use({
    --    'rose-pine/neovim',
    --    as = 'rose-pine',
    --    config = function()
    --        vim.cmd('colorscheme rose-pine')
    --    end
    --})

    -- "=====> chadTREE: https://github.com/ms-jpq/chadtree <=====
    --use ({'ms-jpq/chadtree',
    --    branch = 'chad',
    --    {run = 'python3 -m chadtree deps'}, -- run is equivalent do in vim-plug
    --    config = function()
    --        vim.cmd('CHADdeps')
    --    end
    --})

    use ({'nvim-treesitter/nvim-treesitter',
        {run = ':TSUpdate'},
    } )

    use ('mbbill/undotree')

    use (
        'ms-jpq/coq_nvim',
        {branch = 'coq'}
    )

    -- 9000+ Snippets
    use (
        'ms-jpq/coq.artifacts',
        {branch = 'artifacts'}
    )
    -- " lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
    -- " Need to **configure separately**
    use (
        'ms-jpq/coq.thirdparty',
        {branch = '3p'}
    )
    -- " - shell repl
    -- " - nvim lua api
    -- " - scientific calculator
    -- " - comment banner
    -- " - etc


    -- "=====> https://github.com/andweeb/presence.nvim
    use ('andweeb/presence.nvim')


    -- "=====> ncm-R for Rscripts completion
    use ('ncm2/ncm2')
    use ('roxma/nvim-yarp')
    use ( 'jalvesaq/Nvim-R')
    use ('gaalcaras/ncm-R')


    -- "====> rust-analyzer dependencies

    -- " Use release branch (recommend)
    -- use ('neoclide/coc.nvim', {branch = 'master'})
    -- " Or build from source code by using yarn: https://yarnpkg.com
   -- use ('neoclide/coc.nvim', {
   --     branch = 'master',
   --     run = 'yarn install --frozen-lockfile'
   -- })

    -- " nvim-jdtls
    use ('mfussenegger/nvim-jdtls')



    -- " Vim 8 only
    -- uncomment on vim.init
    -- if !has('nvim')
    --     use ('roxma/vim-hug-neovim-rpc')
    --  endif

    -- Optional: for snippet support
    -- Further configuration might be required, read below
    use ('sirver/UltiSnips')
    use ('ncm2/ncm2-ultisnips')

    -- " Optional: better Rnoweb support (LaTeX completion)
    use ('lervag/vimtex')

    -- lsp-zero
    use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v3.x',
      requires = {
        --- Uncomment these if you want to manage LSP servers from neovim
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},

        -- LSP Support
        {'neovim/nvim-lspconfig'},
        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'L3MON4D3/LuaSnip'},
      }}

end)
