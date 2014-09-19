
" =========================================================================
" Vundle
" =========================================================================
" {{{

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" cpp/h switch
Plugin 'derekwyatt/vim-fswitch'

" creates C++ class method implementations
Plugin 'derekwyatt/vim-protodef'

" Todo plugin
Plugin 'neochrome/todo.vim'

" Git support
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Super increment
Plugin 'VisIncr'

" Color schemes
Plugin 'molokai'

" Auto completion
Plugin 'Valloric/YouCompleteMe'

" Snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" Plugin to show syntax errors
Plugin 'scrooloose/syntastic'

" LaTeX
Plugin 'LaTeX-Box-Team/LaTeX-Box'

" Easy motion
Plugin 'Lokaltog/vim-easymotion'

" Commenting
Plugin 'tomtom/tcomment_vim'

" Unite - obsoletes: command-t, fuzzy-finder and buffer explorer
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/unite.vim'

" ==== SYNTAX =========================

Plugin 'vim-scripts/ck.vim'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'vim-scripts/glsl.vim'

" ==== Other and obsolete  ============

Plugin 'L9'
Plugin 'tpope/vim-surround'
Plugin 'bling/vim-bufferline'

" Plugin 'mkitt/tabline.vim'      " Fuck tabs, use buffers
" Plugin 'scrooloose/nerdtree'    " cmd line is NERDier
" Plugin 'bling/vim-airline'      " change to Powerline
" Plugin 'Lokaltog/vim-powerline' " Comes from system now

call vundle#end()
filetype plugin indent on

" }}}

" =========================================================================
" Settings
" =========================================================================
" {{{

" Encoding
set termencoding=utf-8
set fileencodings=utf-8,cp1251
set encoding=utf-8

" This puts  backup to RAM, faster but risky ;)
set directory=/tmp

" Scheme
colorscheme molokai

" Cursor free positioning
set virtualedit=all

" Highlight syntax
syntax on

" No highlighting limit
"set synmaxcol=0

" Show line numbers
set nu

" Relative numbering for fast jumps
set relativenumber

" allow hidden buffers
set hidden

" place a dollar sign when in change mode to indicate end
set cpoptions+=$

" Remove splash on startup
set shortmess+=I

" Set spell for ru and eng
set spelllang=en,ru

" 2 - always show status line
set laststatus=2

" Update time (def 4000)
set updatetime=750

" Disable file~ backups
set nobackup

" ????
set ruler

" Show command in last line
set showcmd

" Remember 100 commands
set history=100

" Search
set hlsearch
set ignorecase
set smartcase

" Tabs vs spaces
set tabstop=3        " число пробелов для таба
set softtabstop=3    " число пробелов для таба при редактировании
set shiftwidth=3     " число пробелов для отступа при форматировании
set expandtab        " превращать табы в пробелы

" Отступы
set smartindent     " умные отступы
set autoindent

" TODO: read man on wild

set wildmenu
set wildmode=full               " ??
set wildignore=*.o,*.obj,*~     " ????
set wildcharm=<Tab>             " ????

set complete="" " Слова откуда будем завершать
set complete+=. " Из текущего буфера
set complete+=k " Из словаря
set complete+=t " из тегов

set completeopt+=menu      " Выдавать менюшку с дополнениями
"set completeopt+=menuone  " Показывать менюшку, даже если дополнение всего одно
set completeopt+=longest   " Автоматически дописывать совпадающий среди всех возможных дополнений кусок
set completeopt-=preview   " Показывать дополнительную инфу о дополнениях

set foldmethod=syntax

" Russian layout
set keymap=russian-jcukenwin    " C-^ to switch
set iminsert=0                  " insert mode default en
set imsearch=0                  " search mode default en

" Unprintable
set listchars=tab:‣\ ,trail:·,extends:>,eol:¶,precedes:·

" wrapping lines symbol
set showbreak=»

" System default for mappings is now the ',' character
let mapleader = ","

" Setup GVIM separately
if has("gui_running")

   set guifont=PragmataPro\ 12

   " Set default size for GVIM
   set lines=60 columns=200

   " Setup GVIM look, hide useless bars and
   set guioptions-=T
   set guioptions-=m
   set guioptions-=l
   set guioptions-=L
   set guioptions-=r
   set guioptions-=b

   " Bash in gvim will understand my aliases now
   set shell=/bin/bash\ --login

   " Cursor settings
   highlight Cursor guifg=black guibg=white
   highlight iCursor guifg=black guibg=red
   set guicursor=n-v-c:block-Cursor
   set guicursor+=i:ver100-iCursor
   set guicursor+=n-v:blinkon0
   set guicursor+=i-c:blinkwait10

else

   " enable mouse in terminals
   set mouse=a

   " Poor man's terminal spelling colors
   highlight clear SpellBad
   highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
   highlight clear SpellCap
   highlight SpellCap term=underline cterm=underline
   highlight clear SpellRare
   highlight SpellRare term=underline cterm=underline
   highlight clear SpellLocal
   highlight SpellLocal term=underline cterm=underline

   " TODO: cursor play with blinking

endif
" }}}

" =========================================================================
" Plugin settings
" =========================================================================
" {{{

" == NERD Tree ==

let NERDTreeWinPos='right' " Располагаться NerdTree должно справа

" == ProtoDef ==

let g:protodefprotogetter = '/home/randy/.vim/bundle/vim-protodef/pullproto.pl'

" == Airline / Powerline  ==

let g:Powerline_symbols="fancy"

" == Syntastic ==

let g:syntastic_error_symbol="✖"
let g:syntastic_warning_symbol="✦"

" == Unite ==

let g:unite_enable_start_insert = 1
let g:unite_split_rule = "botright"
let g:unite_force_overwrite_statusline = 0
let g:unite_winheight = 10
let g:unite_candidate_icon=">"
let g:unite_source_rec_async_command= 'ag --nocolor --nogroup --hidden -g ""'

" == You complete me ==

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_key_list_previous_completion=['<Up>']

" == Ultisnips ==

let g:UltiSnipsExpandTrigger=",<return>"
let g:UltiSnipsListSnippets="<c-tab>"

" }}}

" =========================================================================
" Helper functions
" =========================================================================
" {{{

function Enable80CharsLimit()
   set colorcolumn=80
   set textwidth=80
   set formatoptions=cqt
   set wrapmargin=0
   highlight ColorColumn ctermbg=235 guibg=#2c2d27
   highlight CursorLine ctermbg=235 guibg=#2c2d27
   highlight CursorColumn ctermbg=235 guibg=#2c2d27
   let &colorcolumn=join(range(81,999),",")
endfunction

function OpenNERDTree()
  execute ":NERDTree"
endfunction

" For fast tests quick compile current file
func! CompileGcc()
  exec "w"
  exec "!g++ % -g -std=c++11 -o %< && ./%< "
endfunc
func! CompileClang()
  exec "w"
  exec "!clang++ % -g -std=c++11 -o %< "
endfunc
func! CompilePerl()
  exec "w"
  exec "!perl %"
endfunc
func! CompilePython()
  exec "w"
  exec "!python %"
endfunc
func! CompileLatex()
  exec "w"
  exec "Latexmk"
endfunc
func! CompileChuck()
  exec ":w"
  exec ":silent !chuck --add ./%"
  exec ":redraw!"
endfunc
func! CompileRust()
  exec ":w"
  exec "!rustc % -o %< && ./%< "
endfunc
func! ReplaceChuck()
  exec "w"
  exec ":silent !chuck --remove.all"
  exec ":redraw!"
endfunc

" Translator with sdcv
function TRANSLATE()
   let  a=getline('.')
   let co=col('.')-1
   let starts=strridx(a," ",co)
   let ends = stridx(a," ",co)
   if ends==-1
       let ends=strlen(a)
   endif
   let res = strpart(a,starts+1,ends-starts)
   let cmds = "sdcv -n " . res
   let out = system(cmds)
   echo out
endfunction

"}}}

" =========================================================================
" Helper menus
" =========================================================================

" Encodings
menu Encoding.UTF-8          :e ++enc=utf-8
menu Encoding.Unicode        :e ++enc=unicode
menu Encoding.UCS-2          :e ++enc=ucs-2le<CR>
menu Encoding.UCS-4          :e ++enc=ucs-4
menu Encoding.KOI8-R         :e ++enc=koi8-r ++ff=unix <CR>
menu Encoding.KOI8-U         :e ++enc=koi8-u ++ff=unix <CR>
menu Encoding.CP1251         :e ++enc=cp1251
menu Encoding.IBM-855        :e ++enc=ibm855
menu Encoding.IBM-866        :e ++enc=ibm866 ++ff=dos <CR>
menu Encoding.ISO-8859-5     :e ++enc=iso-8859-5
menu Encoding.Latin-1        :e ++enc=latin1

" File formats
menu FileFormat.UNIX         :e ++ff=unix
menu FileFormat.DOS          :e ++ff=dos
menu FileFormat.Mac          :e ++ff=mac

" =========================================================================
" Keyboard mappings
" =========================================================================

" Translator function
map <F3>  :call TRANSLATE()<cr>

" Toggle spelling with the F7 key
nnoremap <silent> <F7> <ESC>:setlocal spell!<CR>
inoremap <silent> <F7> <ESC>:setlocal spell!<CR>li

" Toggle keyboard layout
inoremap <silent> <F9> <C-^>

" Toggle unprintable <F10>
nnoremap <silent> <F10> <ESC>:set list!<CR>
inoremap <silent> <F10> <ESC>:set list!<CR>li

map <F11> :emenu Encoding.<Tab><Tab>
map <S-F11> :emenu FileFormat.<Tab><Tab>

" NERD Toggle
nmap <F12> :NERDTreeToggle<CR>

" Make p in Visual mode replace the selected text with the \" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Indentation changes, but visual stays
vnoremap > ><CR>gv
vnoremap < <<CR>gv

" move current line up/down one
nnoremap <c-j> ddp
nnoremap <c-k> ddkP

" move visual block up/down one
vnoremap <c-j> dp'[V']
vnoremap <c-k> dkP'[V']

" cd to the directory containing the file in the buffer
nmap <silent> ,cd :lcd %:h<CR>

" make directory
nmap <silent> ,md :!mkdir -p %:p:h<CR>

" When search done : ,n to unhighlight
nmap <silent> ,n :nohls<CR>

" FSwitch mappings
nmap <silent> ,of :FSHere<CR>
nmap <silent> ,ol :FSRight<CR>
nmap <silent> ,oL :FSSplitRight<CR>
nmap <silent> ,oh :FSLeft<CR>
nmap <silent> ,oH :FSSplitLeft<CR>
nmap <silent> ,ok :FSAbove<CR>
nmap <silent> ,oK :FSSplitAbove<CR>
nmap <silent> ,oj :FSBelow<CR>
nmap <silent> ,oJ :FSSplitBelow<CR>

" Alright... let's try this out
imap jj <esc>

" Line wrap toggle
nmap <silent> ,ww :set invwrap<CR>:set wrap?<CR>

" Buffers
nmap <silent> ,bn :bn<CR>
nmap <silent> ,bp :bp<CR>
nmap <silent> ,bd :bd<CR>

" Make arrow keys not working hehe wee
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <c-y>
noremap   <Down>   <c-e>
noremap   <Left>   zh
noremap   <Right>  zl

" Typos -- I often type :Q instead of :q
command! W w
command! Q q

" Infasters
nmap <space> :

" Search the current file for the word under the cursor and display matches
nmap <silent> ,gw :vimgrep /<C-r><C-w>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

" Edit the vimrc file
nmap <silent> ,ev :e $MYVIMRC<CR>
nmap <silent> ,sv :so $MYVIMRC<CR>

" Yank to end (like D and C)
nnoremap Y y$

" Disable ex-mode toggle
nnoremap Q <nop>

" Remove trailing whitespaces
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

" Sudoing in vim hack, write with forrce!
cmap w!! %!sudo tee > /dev/null %

" When entering command, press %% to quickly insert current path
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Mapping ,, to fast switch between buffers
nmap <silent> ,,<space> <c-^>

" YCM
nnoremap <leader>yy :YcmForceCompileAndDiagnostics<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>gd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR>

" Unite
nnoremap <leader>t :<C-u>Unite -buffer-name=files -start-insert file_rec<cr>
nnoremap <leader>T :<C-u>Unite -buffer-name=files -start-insert file_rec/async:!<cr>
nnoremap <leader>f :<C-u>Unite -buffer-name=files -start-insert buffer file_rec/async:!<cr>
nnoremap <leader>b :<C-u>Unite -quick-match buffer<cr>
nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru -start-insert file_mru<cr>

" }}}

" =========================================================================
" Autos
" =========================================================================
" {{{

" Python
autocmd BufRead *.py nnoremap <silent> <F5> <ESC>:call CompilePython()<CR>
autocmd BufRead *.py inoremap <silent> <F5> <ESC>:call CompilePython()<CR>i

" Perl
autocmd BufRead *.pl nnoremap <silent> <F5> <ESC>:call CompilePerl()<CR>
autocmd BufRead *.pl inoremap <silent> <F5> <ESC>:call CompilePerl()<CR>i

" C++
autocmd BufRead *.cpp nnoremap <silent> <F5> <ESC>:call CompileGcc()<CR>
autocmd BufRead *.cpp inoremap <silent> <F5> <ESC>:call CompileGcc()<CR>i
autocmd BufRead *.cpp call Enable100CharsLimit()
autocmd BufRead *.h   call Enable100CharsLimit()

" Latex
autocmd BufRead *.tex nnoremap <silent> <F5> <ESC>:call CompileLatex()<CR>
autocmd BufRead *.tex inoremap <silent> <F5> <ESC>:call CompileLatex()<CR>i

" Rust
autocmd BufRead *.rs nnoremap <silent> <F5> <ESC>:call CompileRust()<CR>
autocmd BufRead *.rs inoremap <silent> <F5> <ESC>:call CompileRust()<CR>i

" Chuck
autocmd BufRead *.ck exec 'set ft=ck'
autocmd BufRead *.ck nnoremap <silent> <F5> <ESC>:call CompileChuck()<CR>
autocmd BufRead *.ck inoremap <silent> <F5> <ESC>:call CompileChuck()<CR>i
autocmd BufRead *.ck nnoremap <silent> <F6> <ESC>:call ReplaceChuck()<CR>
autocmd BufRead *.ck inoremap <silent> <F6> <ESC>:call ReplaceChuck()<CR>i
autocmd BufRead *.ck call system("killall chuck; chuck --loop &")
autocmd VimLeave *.ck call system("killall chuck &")

" Save views
" autocmd BufWinLeave * silent! mkview
" autocmd BufWinEnter * silent! loadview

" }}}
