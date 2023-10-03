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

  use({
      'rose-pine/neovim',
      as = 'rose-pine',
      config = function()
          vim.cmd('colorscheme rose-pine')
      end
      })

    use ({
        'ms-jpq/chadtree',
        branch = 'chad'
        {run = 'python3 -m chadtree deps'}, -- run is equivalent do in vim-plug
        config = function()
            vim.cmd('CHADdeps')
        end,
        setup = function()
            vim.cmd('CHADdeps')
        end,
      })

      use (
          'nvim-treesitter/nvim-treesitter',
          {run = ':TSUpdate'},
      )

end)
