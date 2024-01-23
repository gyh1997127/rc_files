set foldmethod=syntax
syntax on
filetype plugin indent on
set pyxversion=3
set formatoptions-=ro
set splitright
set showmatch
set noerrorbells
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set shiftround
"set smartindent
set autoindent
set nu
set wrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set hlsearch
set ic
set breakindent
set linebreak
"for vim and bash encoding issue
set encoding=utf-8
set termencoding=utf-8
let &t_TI = ""
let &t_TE = ""
"lightline handles vim mode now
set noshowmode
"lightline ESC key lags, reducing keystroke timeoutlength
set ttimeout ttimeoutlen=100
"lightline now showing up
set laststatus=2
"for vim-polyglot
set nocompatible
" enable scrolling
set mouse=a
let mapleader = " "

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey
set cc=""

"remap keys
nnoremap <Leader>w :w<CR>
if executable('rg')
  let g:rg_derive_root='true'
endif
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
map <silent> <leader><cr> :noh<cr>
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
"open search for fast search
map <leader>f /
" Close current buffer
map <leader>bd :bd<cr>
" Close all buffers
map <leader>ba :%bd!<cr>
" List all buffers
map <leader>bs :buffers<cr>
set backspace=indent,eol,start
nnoremap <S-k> :m-2<CR>
nnoremap <S-j> :m+<CR>
vnoremap <S-j> :m '>+1<CR>gv=gv
vnoremap <S-k> :m '<-2<CR>gv=gv
"move lines up and down
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
" JJ is Esc
imap jj <Esc>
" open tag result in new vert split
nnoremap <C-]> <C-W><C-V><C-]>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plug')
" git
Plug 'tpope/vim-fugitive'

Plug 'ycm-core/YouCompleteMe'

" Markdown
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
"Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
  " markdown configs
  "autocmd FileType markdown set conceallevel=0
  "autocmd FileType markdown normal zR
  let g:vim_markdown_frontmatter=1
  let g:vim_markdown_strikethrough=1
  let g:mkdp_refresh_slow = 1
  let g:mkdp_markdown_css='/Volumes/MACDATA/Tools/rc_files/github-markdown-css.css'

  " Markdown Preview setting
  let g:mkdp_theme = 'light'
  let g:mkdp_markdown_css = '/Volumes/MACDATA/Tools/github-markdown-css/github-markdown.css'
  let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ }

"align texts
 Plug 'godlygeek/tabular'

"Nerd Comment
Plug 'preservim/nerdcommenter'
  let g:NERDCreateDefaultMappings = 1

" fast searching
Plug 'junegunn/fzf' ", { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
  let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
  nnoremap <Leader>pf :Files<CR>
  " fuzzy search commnad
  "command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

Plug 'sheerun/vim-polyglot'

Plug 'scrooloose/nerdTree'
  nmap <leader>b :NERDTreeToggle<CR>
  let g:NERDTreeDirArrows=2
  let g:NERDTreeDirArrowExpandable='|'
  let g:NERDTreeDirArrowCollapsible='+'
  let g:NERDTreeChDirMode = 2

Plug 'sainnhe/gruvbox-material'
   if has('termguicolors')
     set termguicolors
   endif
   set background=dark
   let g:gruvbox_material_background = 'medium'
   let g:gruvbox_material_better_performance = 1

Plug 'itchyny/lightline.vim'
  let g:lightline = {'colorscheme' : 'gruvbox_material'}
  let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \       [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" systemverilog
Plug 'vhda/verilog_systemverilog.vim'
  let g:verilog_syntax_fold_lst = "class,function,task"

" fold
"Plug 'Konfekt/FastFold'
  "nmap <F6> <Plug>(FastFoldUpdate)
  "let g:fastfold_savehook = 1
  "let g:fastfold_fold_command_suffixes = []
  "let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
  "autocmd FileType sv,svh,v setlocal foldmethod=syntax

" tagbar
Plug 'preservim/tagbar'
Plug 'ludovicchabant/vim-gutentags'
  nmap <F8> :TagbarToggle<CR>

" latex
Plug 'lervag/vimtex'
  let g:tex_flavor='latex'
  let g:vimtex_view_method = 'skim' " Choose which program to use to view PDF file
  let g:vimtex_view_skim_sync = 1 " Value 1 allows forward search after every successful compilation
  let g:vimtex_view_skim_activate = 1 " Value 1 allows change focus to skim after command `:VimtexView` is given
  "let g:vimtex_view_general_viewer = 'qpdfview'
  "let g:vimtex_view_general_options = '--unique @pdf\#src:@tex:@line:@col'
  syntax enable

Plug 'KeitaNakamura/tex-conceal.vim'
  set conceallevel=2
  let g:tex_conceal='abdmg'
  hi Conceal ctermbg=none

Plug 'mtdl9/vim-log-highlighting'

call plug#end()

" this has to be called AFTER plug#end()
colorscheme gruvbox-material

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

