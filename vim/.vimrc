"install plugins
call plug#begin('~/.vim/plugged')
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'fatih/molokai'
  Plug 'AndrewRadev/splitjoin.vim'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
            \ Plug 'ryanoasis/vim-devicons'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'
  Plug 'tmhedberg/SimpylFold'
  Plug 'vim-scripts/indentpython.vim'
  Plug 'vim-syntastic/syntastic'
  Plug 'nvie/vim-flake8'
  Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
call plug#end()

"enable color scheme
let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai

"vim specific stuff
nnoremap <SPACE> <Nop>
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let mapleader=" "

set autowrite
set showcmd
set number
set laststatus=2
set statusline=%f
set updatetime=100
set encoding=UTF-8
set clipboard=unnamed

"tab related things
set switchbuf=usetab,newtab
nnoremap <F8> :sbnext<CR>
nnoremap <S-F8> :sbprevious<CR>

nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <silent> <A-Left> :tabm -1<CR>
nnoremap <silent> <A-Right> :tabm +1<CR>
"toggle all current buffers as tabs.
let notabs = 0
nnoremap <silent> <F8> :let notabs=!notabs<Bar>:if notabs<Bar>:tabo<Bar>:else<Bar>:tab ball<Bar>:tabn<Bar>:endif<CR>

"coc.nvim config
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <NUL> coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"===========NERDTree config===========
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-c> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror

"SimpylFold config
let g:SimpylFold_docstring_preview=1

"Change default arrows
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

"NERDtree with git config
let g:NERDTreeGitStatusUntrackedFilesMode = 'all'
let g:NERDTreeGitStatusShowClean = 1
let NERDTreeIgnore=['\.pyc$', '\~$']

"set go tooling options
let g:go_fmt_command 		= "goimports"
let g:go_addtags_transform 	= "camelcase"
let g:go_auto_type_info 	= 1
let g:go_auto_sameids 		= 1
let g:go_play_open_browser 	= 0

"too slow for autosave
"Use :GoMetaLint
""let g:go_metalinter_autosave = 1
""let g:go_metalinter_autosave_enabled = ['vet', 'golint']
""let g:go_metalinter_deadline = "5s"

"syntax highlighting options
let g:go_highlight_types 		= 1
let g:go_highlight_fields 		= 1
let g:go_highlight_functions 		= 1
let g:go_highlight_function_calls 	= 1
let g:go_highlight_extra_types 		= 1
let g:go_highlight_build_constraints 	= 1
let g:go_highlight_generate_tags 	= 1

"Python specific syntax stuff
let python_highlight_all=1
syntax on

"configure tab related settings
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 

autocmd BufNewFile,BufRead *.cpp setlocal noexpandtab tabstop=4 shiftwidth=4

autocmd BufNewFile,BufRead *.c setlocal noexpandtab tabstop=4 shiftwidth=4
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

autocmd BufNewFile,BufRead *.json setlocal noexpandtab tabstop=4 shiftwidth=2
autocmd BufNewFile,BufRead *.md setlocal noexpandtab tabstop=4 shiftwidth=2

autocmd BufNewFile,BufRead *.y setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.l setlocal noexpandtab tabstop=4 shiftwidth=4

"Flag unescessary whitespaces
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"set keybindings for vim-go
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
map <C-x> :GoSameIdsClear<CR>
nnoremap <leader>p :cclose<CR>

"add keybindings for commonly used vim-go 
"specific commands
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>tf <Plug>(go-test-func)
autocmd FileType go nmap <leader>tc <Plug>(go-test-compile)
autocmd FileType go nmap <Leader>c  <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>i  <Plug>(go-imports)
autocmd FileType go nmap <Leader>d  <Plug>(go-def)
autocmd FileType go nmap <Leader>i  <Plug>(go-info)

autocmd Filetype go command! -bang A  call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" based on type of file, call GoBuild or GoTestCompile for
" the same key binding
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
