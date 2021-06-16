return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}
  use 'ActivityWatch/aw-watcher-vim'
  use 'lervag/vimtex'
  use 'NLKNguyen/papercolor-theme'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'vimwiki/vimwiki'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'hrsh7th/vim-vsnip'
  use 'rafamadriz/friendly-snippets'
end)
