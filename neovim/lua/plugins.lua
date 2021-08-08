local use = require('packer').use
return require('packer').startup(
  function()
    use 'wbthomason/packer.nvim'
    use 'dracula/vim'
    use 'morhetz/gruvbox'
    use 'arcticicestudio/nord-vim'
    use '9mm/vim-closer'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'tpope/vim-vinegar'
    use 'nvim-treesitter/nvim-treesitter'
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/completion-nvim'
    use 'nvim-lua/diagnostic-nvim'
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        {'nvim-lua/popup.nvim'},
        {'nvim-lua/plenary.nvim'}
      }
    }
  end
)
