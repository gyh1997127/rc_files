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

set colorcolumn=120
highlight ColorColumn ctermbg=0 guibg=lightgrey

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

" Jedi autocomplete
Plug 'ervandew/supertab'
  let g:SuperTabDefaultCompletionType = '<C-n>'

" LSP
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
au BufRead,BufNewFile *.sv,*.svh set filetype=systemverilog
" --- LSP Key Mappings ---
" Only map keys if the language server supports the feature
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

    nmap <buffer> Gd <plug>(lsp-definition)
    nmap <buffer> Gr <plug>(lsp-references)
    nmap <buffer> Gi <plug>(lsp-implementation)
    nmap <buffer> Gh <plug>(lsp-hover)
    nmap <buffer> <F2> <plug>(lsp-rename)
endfunction
augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
let s:slang_path = expand('~/.local/share/vim-lsp-settings/servers/slang-server')
function! s:get_slang_root(buffer_path) abort
    let l:root = lsp#utils#find_nearest_parent_file_directory(a:buffer_path, ['.slang'])
    
    " If no .slang or .git is found, use the file's current directory
    if empty(l:root)
        let l:root = fnamemodify(a:buffer_path, ':p:h')
    endif
    
    return lsp#utils#path_to_uri(l:root)
endfunction
if executable(s:slang_path)
    augroup LspSlangServer
        au!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'slang-server',
            \ 'cmd': {server_info->[s:slang_path]},
            \ 'allowlist': ['systemverilog', 'verilog', 'verilog_systemverilog'],
            \ 'languageId': {server_info->'systemverilog'},
            \ 'root_uri': {server_info->s:get_slang_root(lsp#utils#get_buffer_path())},
            \ })
    augroup END
endif

Plug 'SirVer/ultisnips'
  let g:UltiSnipsExpandTrigger = "<tab>"
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
  let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
Plug 'gyh1997127/vim-snippets'

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
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8, 'relative': v:true } }
  nnoremap <Leader>pf :Files<CR>
  nnoremap <Leader>rg :Rg<CR>
  command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, {'options': ['--info=inline', '--preview', 'cat {}']}, <bang>0)
  command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" '.shellescape(<q-args>), 1, <bang>0)
  let g:fzf_colors =
        \ { 'fg':      ['fg', 'Normal'],
        \ 'bg':      ['bg', 'Normal'],
        \ 'hl':      ['fg', 'Comment'],
        \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
        \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
        \ 'hl+':     ['fg', 'Statement'],
        \ 'info':    ['fg', 'PreProc'],
        \ 'border':  ['fg', 'Ignore'],
        \ 'prompt':  ['fg', 'Conditional'],
        \ 'pointer': ['fg', 'Exception'],
        \ 'marker':  ['fg', 'Keyword'],
        \ 'spinner': ['fg', 'Label'],
        \ 'header':  ['fg', 'Comment'] }

Plug 'sheerun/vim-polyglot'

Plug 'scrooloose/nerdTree'
  nmap <leader>b :NERDTreeToggle<CR>
  let g:NERDTreeDirArrows=2
  let g:NERDTreeDirArrowExpandable='|'
  let g:NERDTreeDirArrowCollapsible='+'
  let g:NERDTreeChDirMode = 2

" systemverilog
Plug 'vhda/verilog_systemverilog.vim'
  let g:verilog_syntax_fold_lst = "covergroup,function,task"

" tagbar
Plug 'preservim/tagbar'
Plug 'ludovicchabant/vim-gutentags'
  " tagbar toggle
  nmap <F8> :TagbarToggle<CR>

Plug 'KeitaNakamura/tex-conceal.vim'
  set conceallevel=2
  let g:tex_conceal='abdmg'
  hi Conceal ctermbg=none

Plug 'mtdl9/vim-log-highlighting'

" indent line
Plug 'nathanaelkane/vim-indent-guides'

Plug 'NLKNguyen/papercolor-theme'

Plug 'davidosomething/vim-colors-meh'

Plug 'aditya-azad/candle-grey'

Plug 'andreasvc/vim-256noir'

Plug 'junegunn/seoul256.vim'

Plug 'sainnhe/gruvbox-material'
   let g:gruvbox_material_background = 'medium'
   let g:gruvbox_material_better_performance = 1
   let g:gruvbox_material_disable_italic_comment = 1

Plug 'itchyny/lightline.vim'
  let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \       [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

call plug#end()

" this has to be called AFTER plug#end()
"colorscheme meh
"colorscheme 256_noir
"colorscheme seoul256
colorscheme gruvbox-material
set termguicolors
set background=dark

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
