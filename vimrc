""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NOTES
""""""""""""""""""""""""""""""""""""""""""""""""""""
" this is a basic vimrc. it's a single file with
" minimal plugins and it's got everything i need.
" 
" need to install: vim, ripgrep, fd, fzf
"
"
""""""""""""""""""""""""""""""""""""""""""""""""""""
" => OPTIONS
""""""""""""""""""""""""""""""""""""""""""""""""""""
set number
set relativenumber

filetype plugin indent on
syntax on

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set smartindent

set ignorecase
set smartcase
set incsearch

set background=dark
set signcolumn=yes

set splitbelow
set splitright

set iskeyword+=-

set path+=**
set wildmenu

set scrolloff=8

set laststatus=2

" netrw tweaks
let g:netrw_banner=0       " disable banner
let g:netrw_liststyle=3    " tree view
   
""""""""""""""""""""""""""""""""""""""""""""""""""""
" => PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:plugin_dir = expand('~/.vim/plugged')

function! s:ensure(repo)
    let name = split(a:repo, '/')[-1]
    let path = s:plugin_dir . '/' . name

    if !isdirectory(path)
        if !isdirectory(s:plugin_dir)
            call mkdir(s:plugin_dir, 'p')
        endif
        execute '!git clone --depth=1 https://github.com/' . a:repo . ' ' . shellescape(path)
    endif

    execute 'set runtimepath+=' . fnameescape(path)
endfunction

call s:ensure('ghifarit53/tokyonight-vim')
call s:ensure('junegunn/fzf')
call s:ensure('junegunn/fzf.vim')
call s:ensure('tomasiser/vim-code-dark')
call s:ensure('yegappan/lsp')
call s:ensure('ojroques/vim-oscyank')
call s:ensure('tpope/vim-commentary')

""""""""""""""""""""""""""""""""""""""""""""""""""""
" => KEYBINDS
""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = " "

" Fast write, quit, source, file explorer
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>o :so<CR>
nnoremap <leader>O :source $MYVIMRC<CR>
nnoremap <leader>e :Ex<CR>

" Tab stuff
nnoremap <leader>t <Cmd>tabnew<CR>
nnoremap <leader>x <Cmd>tabclose<CR>

" Centered search :)
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

" :norm
map <leader>n :norm 

" Avoid accidental Q
nnoremap Q <nop>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<CR>:pwd<CR>

" Getting to files fast
map <leader>v <Cmd>edit $MYVIMRC<CR>
map <leader>z <Cmd>e ~/.config/zsh/.zshrc<CR>

" Mini telescope
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fo :History<CR>
nnoremap <leader>fb :Buffers<CR>

nnoremap <leader>fg :Rg<Space>

""""""""""""""""""""""""""""""""""""""""""""""""""""
" => LSP
""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable diagnostics highlighting
let lspOpts = #{autoHighlightDiags: v:true}
autocmd User LspSetup call LspOptionsSet(lspOpts)
let lspServers = [
      \ #{
      \   name: 'rust-analyzer',
      \   filetype: ['rust'],
      \   path: 'rust-analyzer',
      \   args: []
      \ },
      \ #{
      \   name: 'clang',
      \   filetype: ['c'],
      \   path: 'clang',
      \   args: []
      \ }
      \ ]

autocmd User LspSetup call LspAddServer(lspServers)

" Key mappings
nnoremap gd :LspGotoDefinition<CR>
nnoremap gr :LspShowReferences<CR>
nnoremap K  :LspHover<CR>
nnoremap gl :LspDiag current<CR>
nnoremap <leader>] :LspDiag next \| LspDiag current<CR>
nnoremap <leader>[ :LspDiag prev \| LspDiag current<CR>
inoremap <silent> <C-Space> <C-x><C-o>

" Set omnifunc for completion
autocmd FileType php setlocal omnifunc=lsp#complete

" Custom diagnostic sign characters
autocmd User LspSetup call LspOptionsSet(#{
    \   diagSignErrorText: '✘',
    \   diagSignWarningText: '▲',
    \   diagSignInfoText: '»',
    \   diagSignHintText: '⚑',
    \ })

""""""""""""""""""""""""""""""""""""""""""""""""""""
" => COLORS
""""""""""""""""""""""""""""""""""""""""""""""""""""
set termguicolors

let g:tokyonight_style = 'night' " night/storm
let g:tokyonight_enable_italic = 1

colorscheme tokyonight
