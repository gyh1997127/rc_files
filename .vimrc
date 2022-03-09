syntax on

set foldenable
set foldmethod=syntax
set pyxversion=3
set formatoptions-=ro
set splitright
set showmatch
set noerrorbells
set tabstop=4 
set softtabstop=4
set shiftwidth=4
set noexpandtab
set shiftround
set autoindent
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
set ttimeout ttimeoutlen=20
"lightline now showing up
set laststatus=2
"for vim-polyglot
set nocompatible
" enable scrolling
set mouse=a

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey
set cc=""
" Windows font
" set guifont=KaiTi:h11

call plug#begin('~/.vim/plugged')
" YouCompleteme
Plug 'Valloric/YouCompleteMe', {'do': './install.py --clangd-completer'}

" Markdown 
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
"Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" color package
Plug 'gruvbox-community/gruvbox'

"align texts
 Plug 'godlygeek/tabular'

"Nerd Comment
Plug 'preservim/nerdcommenter'

" fast searching
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"status line 
Plug 'itchyny/lightline.vim'

" Syntaxes for a lot of languages
Plug 'sheerun/vim-polyglot'
"Projeect tree
 Plug 'scrooloose/nerdTree'
"auto parenthesis
"Plug 'jiangmiao/auto-pairs'

"color schemes"
Plug 'colepeters/spacemacs-theme.vim'
Plug 'sainnhe/gruvbox-material'
Plug 'phanviet/vim-monokai-pro'
Plug 'flazz/vim-colorschemes'
Plug 'chriskempson/base16-vim'

" systemverilog 
Plug 'vhda/verilog_systemverilog.vim'

" tagbar
Plug 'preservim/tagbar'

" latex
Plug 'lervag/vimtex'

" snippets
Plug 'sirver/ultisnips'
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
Plug 'lervag/vimtex'
    let g:tex_flavor='latex'
    let g:vimtex_view_method='zathura'
    let g:vimtex_quickfix_mode=0
Plug 'KeitaNakamura/tex-conceal.vim'
    set conceallevel=1
    let g:tex_conceal='abdmg'
    hi Conceal ctermbg=none

call plug#end()


"color stuff"
colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'

" --- vim go (polyglot) settings.
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_auto_sameids = 1

if executable('rg')
    let g:rg_derive_root='true'
endif
let mapleader = " "

" fzf config
" fuzzy search box config
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
" fuzzy search commnad
"command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

"remap keys
nnoremap <Leader>w :w<CR>
nnoremap <Leader>pf :Files<CR>
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
map <leader>f :/
" Close current buffer
map <leader>bd :bd<cr>
" Close all buffers
map <leader>ba :%bd!<cr>
" List all buffers
map <leader>bs :buffers<cr>
set backspace=indent,eol,start
" open nerdtree 
nmap <leader>b :NERDTreeToggle<CR>
" open terminal in vim
nmap <leader>t :term<CR>
"let g:NERDTreeDirArrows=0
let g:NERDTreeDirArrowExpandable='|'
let g:NERDTreeDirArrowCollapsible='+'

"move lines up and down
nnoremap <S-k> :m-2<CR>
nnoremap <S-j> :m+<CR>
vnoremap <S-j> :m '>+1<CR>gv=gv
vnoremap <S-k> :m '<-2<CR>gv=gv

" deoplete config
let g:deoplete#enable_at_startup = 1
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
"close scratch automatically
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" markdown configs
autocmd FileType markdown set conceallevel=0
autocmd FileType markdown normal zR
let g:vim_markdown_frontmatter=1
let g:vim_markdown_strikethrough=1
let g:mkdp_refresh_slow = 1
let g:mkdp_markdown_css='/Volumes/MACDATA/Tools/rc_files/github-markdown-css.css'

" YCM Keymaps
nnoremap <leader>g :YcmCompleter GoTo<CR>
let g:ycm_global_ycm_extra_conf = '/Users/yuhuig/.vim/plugged/YouCompleteMe/third_party/ycmd/ycmd/global_ycm_extra_conf.py'
let g:ycm_clangd_binary_path = '/localhdd/yuhuig/tools/clangd_12.0.0/bin/clangd' 

" Folding mapping
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

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

" .v/.sv settings
"autocmd BufRead,BufNewFile *.v,*.vh setfiletype verilog
autocmd BufRead,BufNewFile *.v,*.vh set expandtab tabstop=4 softtabstop=2 shiftwidth=2
"autocmd BufRead,BufNewFile *.sv,*.svi set filetype=verilog_systemverilog
autocmd BufRead,BufNewFile *.sv,*.svi set expandtab tabstop=4 softtabstop=2 shiftwidth=2

" auto generate and update tags
function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let cmd = 'ctags -a -f ' . tagfilename . ' --c++-kinds=+p --fields=+iaS --extras=+q ' . '"' . f . '"'
  call DelTagOfFile(f)
  let resp = system(cmd)
endfunction
autocmd BufWritePost *.cpp,*.h,*.c,*.sv,*.svi,*.v call UpdateTags()

" tagbar toggle 
nmap <F8> :TagbarToggle<CR>

" vimtex
" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note that most plugin managers will do this automatically.
filetype plugin indent on
" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements" for more
" info).
syntax enable
" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
"let g:vimtex_view_method = 'zathura'
" Or with a generic interface:
let g:vimtex_view_general_viewer = 'masterpdfeditor4'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
 "see :help vimtex-compiler.
"let g:vimtex_compiler_method = 'latexrun'
" Most VimTeX mappings rely on localleader and this can be changed with the
" following line. The default is usually fine and is the symbol "\.
"let maplocalleader = ",

" snippet
setlocal spell
set spelllang=en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

