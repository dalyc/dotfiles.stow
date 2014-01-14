" Notes: you are suggested to see
"        http://vimdoc.sourceforge.net/htmldoc/options.html
"        for more information.

"Call pathogen first
call pathogen#infect()
"Set character encoding
set encoding=utf-8
"This option stops vim from behaving in a strong vi-compatible way.
"It should be at the start of any vimrc file as it can affect lots
"of other options which you may want to override.
set nocompatible
"The VIM software has had several remote vulnerabilities
"discovered within VIM's modeline support.
set nomodeline
"allows you to switch from an unsaved buffer without saving it first
set hidden
"completition
set ofu=syntaxcomplete#Complete
"keep attributes of original file
set backupcopy=yes
"store backups under ~/.vim/backup
set backupdir=$HOME/.vim/backup
"keep swap under ~/.vim/swap
set directory=~/.vim/swap
"disable beeps
set noerrorbells visualbell t_vb=
if has('autocmd')
      autocmd GUIEnter * set visualbell t_vb=
endif

" Theme settings
"-----------------------
"Highlight unwanted spaces
autocmd colorscheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
"Set colorscheme
set t_Co=256
colorscheme dc2
syntax on
set number
set cursorline
" set colorcolumn=80
" highlight colorcolumn ctermbg=233

" Indentation
"-----------------------
if has("autocmd")
    filetype plugin indent on
endif
"how many spaces we want for tabs
set tabstop=4
"amount of whitespace to insert using
"indent commands in normal mode
set shiftwidth=4
set softtabstop=4
"replace tabs for spaces
set expandtab

" Code folding
"--------------------------
if has ('folding')
  set foldenable
  set foldmethod=marker
  set foldmarker={{{,}}}
  set foldcolumn=0
endif

" Mail
"--------------------------
autocmd FileType mail,human set formatoptions+=t textwidth=72

" Python stuff
"--------------------------
autocmd FileType python let python_highlight_all = 1
autocmd FileType python let python_slow_sync = 1
autocmd FileType python set expandtab shiftwidth=4 softtabstop=4
autocmd FileType python set completeopt=preview
autocmd FileType python setl nosmartindent

" Binds
"--------------------------
inoremap <F1> <C-O>b
nnoremap <F1> b
inoremap <F2> <C-O>w
nnoremap <F2> w
nnoremap <F3> :set hlsearch! hlsearch?<CR>
inoremap <F9> <C-O><C-^>
nnoremap <F9> <C-^>
nmap <F11> :SCCompile<cr>
"run the compiled program
nmap <F12> :!./%:r<cr>

" Mapleader
"--------------------------
let mapleader = "`"
map <leader>1 "+y
map <leader>2 "+p
nmap <leader>l :set list!<CR>
nmap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>f :ls<CR>:b<space>
nnoremap <leader>s :set nospell!<CR>

" Invisible chars
"--------------------------
set listchars=tab:→\ ,trail:·\,eol:¬
highlight NonText ctermfg=237
highlight SpecialKey ctermfg=234

" Gist settings
"--------------------------
let g:gist_detect_filetype = 1
let g:gist_show_privates   = 1
let g:gist_post_private    = 1

" NERDtree settings
"--------------------------
let g:NERDTreeChDirMode = 2
let g:NERDTreeIgnore    = ['\~$', '\.swp$', '\.o$', '\.hi$']
let g:NERDTreeMinimalUI = 1

" Ultisnip settings
"--------------------------
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsSnippetDirectories  = ["my_snippets"]
