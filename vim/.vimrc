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

" Theme settings/vim ui
"-----------------------
set title
"Highlight screen line of the cursor with CursorLine
set cursorline
"Show partial command in the last line of the screen
set showcmd
"Avoid all the hit-enter prompts caused by file messages
set shortmess=at
"Show line and column number of the cursor position, separated by a comma
set ruler
"Precede each line with its line number
set number
"The value of this option influences when the last window will have a status
"line. 0=never; 1=iff there are at least two windows; 2=always.
set laststatus=1
set scrolloff=3
"When on, command-line-completition operates in an enhanced mode.
set wildmenu wildmode=list:longest,full
"A comma separated list of options for Insert Mode completition
set completeopt=longest,menuone
"Ask for confirmation when executing a command
set confirm
"All windows are automatically made the same size after splitting or closing.
set equalalways
"The screen will not be redrawn while executing macros, registers, and other
"commands that have not been typed.
set lazyredraw
"Highlight unwanted spaces
autocmd colorscheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
"Set colorscheme
set t_Co=256
colorscheme bpeakOwn
syntax on
"Highlight column. Code found on Internet.
"If colorcolumn is off and textwidth is set the use colorcolumn=+1
"If colorcolumn is off and textwidth is not set then use colorcolumn=80
"If colorcolumn is on then turn it off
"use: nmap <Leader>cc :call ColorColumn()<CR>
function! ColorColumn()
    if empty(&colorcolumn)
        if empty(&textwidth)
            echo "colorcolumn=80"
            setlocal colorcolumn=80
        else
            echo "colorcolumn=+1 (" . (&textwidth + 1) . ")"
            setlocal colorcolumn=+1
        endif
    else
        echo "colorcolumn="
        setlocal colorcolumn=
    endif
endfunction
highlight colorcolumn ctermbg=232


" Indentation
"-----------------------
if has("autocmd")
    filetype plugin indent on
    set autoindent
endif
"how many spaces we want for tabs
set tabstop=4
"amount of whitespace to insert using
"indent commands in normal mode
set shiftwidth=4 softtabstop=4
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
autocmd FileType mail,human set spell spelllang=en,es


" Markdown
"--------------------------
autocmd FileType rst,markdown set wrap linebreak nolist
autocmd FileType rst,markdown set spell spelllang=en

" C stuff
"--------------------------
let c_space_errors = 1
autocmd FileType c set wrap linebreak nolist
" Automatically remove unwanted whitespace when saving a file
" this might be dangerous, since sometimes we desire this whitespaces.
" Use with care!
autocmd FileType c autocmd BufWritePre <buffer> :%s/\s\+$//e
"Use :cope to view a window with the errors
"gcc program.c -g -o program.out
autocmd FileType c set makeprg=gcc\ %<.c\ -g\ -o\ %<.out

" Python stuff
"--------------------------
let python_highlight_space_errors = 1
autocmd FileType python let python_highlight_all = 1
autocmd FileType python let python_slow_sync = 1
autocmd FileType python set tabstop=4 expandtab shiftwidth=4 softtabstop=4
autocmd FileType python set completeopt=preview

" Invisible chars
"--------------------------
set listchars=tab:→\ ,trail:·\,eol:¬
highlight NonText ctermfg=237
highlight SpecialKey ctermfg=234

" GUI Settings
"--------------------------
if has ('gui_running')
    set guifont=DejaVu\ Sans\ Mono\ 11
    set guioptions=acM
endif

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
let g:NERDTreeWinPos = "right"

" Ultisnip settings
"--------------------------
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsSnippetDirectories  = ["my_snippets"]

" Binds
"--------------------------
inoremap <F1> <C-O>b
nnoremap <F1> b
inoremap <F2> <C-O>w
nnoremap <F2> w
nnoremap <F3> :set hlsearch! hlsearch?<CR>
set pastetoggle=<F4>
"Compile the current C program in buffer
"%<.c is used intentionally to output an error
"when we try to compile a file that is not C.
nmap <F11> :!gcc %<.c -g -o %<.out<cr>
"run the compiled program
nmap <F12> :!./%:r.out<cr>
"toggle between last tabs
let g:lasttab = 1
au TabLeave * let g:lasttab = tabpagenr()
map <c-\> :exe "tabn ".g:lasttab<CR>
"toggle between buffers
inoremap <F5> <C-O><C-^>
nnoremap <F5> <C-^>

" Mapleader
"--------------------------
let mapleader = '\'
map <leader>1 1gt
map <leader>2 2gt
map <leader>3 3gt
map <leader>4 4gt
map <leader>5 5gt
map <leader>6 6gt
map <leader>7 7gt
map <leader>8 8gt
map <leader>9 9gt
map <leader>t <Esc>:tabnew<CR>
map <leader>y "+y
map <leader>p "+p
nmap <leader>l :set list!<CR>
nmap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>f :ls<CR>:b<space>
nnoremap <leader>s :set nospell!<CR>
nnoremap <silent> <leader>cc :call ColorColumn()<CR>
"Change between edited lines
map <leader>i g,
map <leader>o g;
