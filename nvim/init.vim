" -----------------------------------------------------------------------------
" General Settings
" -----------------------------------------------------------------------------

set number
set clipboard=unnamedplus


set statusline=%f\ %h%w%m%r
set statusline+=%{FugitiveStatusline()}
set statusline+=%=
set statusline+=%-14.(%l,%c%V%)\ %P

" -----------------------------------------------------------------------------
" Plugins
" -----------------------------------------------------------------------------


call plug#begin()

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf.vim'
Plug 'jessarcher/vim-heritage'
Plug 'shirk/vim-gas'
Plug 'nvim-orgmode/orgmode'

Plug 'sheerun/vim-polyglot'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'hrsh7th/nvim-cmp'
Plug 'rust-lang/rust.vim'
Plug 'hrsh7th/cmp-nvim-lsp'

Plug 'Mofiqul/dracula.nvim'

Plug 'preservim/tagbar'
Plug 'ap/vim-buftabline'
Plug 'tpope/vim-surround'
Plug 'windwp/nvim-ts-autotag'
Plug 'windwp/nvim-autopairs'

call plug#end()

lua require('config')

syntax enable
filetype plugin indent on

let g:fzf_layout = {'up':'~90%',
		\ 'window': {
		\		'width':1.0,
		\		'height':0.2,
		\		'yoffset':1.0,
		\		'xoffset':0.0,
		\		'border':'sharp'
		\		}
		\ }

