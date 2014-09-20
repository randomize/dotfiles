" Vim config
"   vim: foldmethod=marker
"
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
" Plugin 'benjaminwhite/Benokai'

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

" Indent guides
Plugin 'nathanaelkane/vim-indent-guides'

" Tabling
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'godlygeek/tabular'

" ==== SYNTAX =========================

Plugin 'vim-scripts/ck.vim'
Plugin 'vim-scripts/glsl.vim'

" ==== Other and obsolete  ============

Plugin 'L9'
Plugin 'tpope/vim-surround'
Plugin 'bling/vim-bufferline'

" Plugin 'mkitt/tabline.vim'      " Fuck tabs, use buffers
" Plugin 'scrooloose/nerdtree'    " cmd line is NERDier
" Plugin 'bling/vim-airline'      " change to Powerline
" Plugin 'Lokaltog/vim-powerline' " Comes from system now
" Plugin 'majutsushi/tagbar'      " Conflicts with YCM

call vundle#end()
filetype plugin indent on

" }}}


" =========================================================================
" Colors (should precede colorscheme command)
" =========================================================================
" {{{

" Show whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=124 guibg=red
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" }}}

" =========================================================================
" Settings
" =========================================================================
" {{{

" Encoding
set termencoding=utf-8
set fileencodings=utf-8,cp1251
set encoding=utf-8

" Set spell for ru and eng
set spelllang=en,ru


" Scheme
colorscheme molokai

" Cursor free positioning
set virtualedit=all

" Highlight syntax
syntax on

" No highlighting limit
"set synmaxcol=0

" Visual
set number         " Show line numbers
set relativenumber " Relative numbering for fast jumps
set novisualbell   " No blinking
set noerrorbells   " No noise
set laststatus=2   " 2 - always show status line
set ruler          " Show ruler
set showcmd        " Show command in last line
set shortmess+=I   " Remove splash on startup
set showbreak=»    " wrapping lines symbol
set nowrap         " Not wrap by default
set formatoptions-=t          " Don't wrap while typing

" Unprintable
set nolist
set listchars=tab:‣\ ,trail:·,extends:>,eol:¶,precedes:·

" Buffers ans splits
set hidden " allow hidden buffers
set splitbelow " new splits go down
set splitright " and right


" place a dollar sign when in change mode to indicate end
set cpoptions+=$

" Update time (def 4000)
set updatetime=750

" Keystrokes timeout
set timeoutlen=2000

" Backups
set nobackup         " Disable file~ backups
set directory=/tmp   " This puts  backup to RAM, faster but risky ;)

" Remember 100 commands
set history=100

" Search
set hlsearch     " Highlight search results
set ignorecase   " no sensitive to case
set smartcase    " When meet uppercase -> sensitive
set noincsearch  " Do not use incremental : type, then start search

" Tabs ans indentation
set tabstop=3       " Tab size
set softtabstop=3   " Tab size in inset mode
set shiftwidth=3    " <> shift size
set expandtab       " Tabs to spaces
set smarttab        " Consolidated editing
set smartindent     " When starting new line repeat indentation
set autoindent

set wildmenu
set wildmode=full
set wildignore=*.o,*.obj,*~
set wildcharm=<Tab>

" Vim's default completion
set complete+=k
set complete+=kspell
set completeopt="menu,menuone,longest,preview"

" Folding
set foldenable
set foldmethod=syntax
set foldlevel=100       " Unfold on start
set foldopen=block,hor,mark,percent,quickfix,tag

" Russian layout
set keymap=russian-jcukenwin    " C-^ to switch
set iminsert=0                  " insert mode default en
set imsearch=0                  " search mode default en


" Modeline
set modeline
set modelines=5

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

" == Indent guides ==

let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=darkgrey ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgrey ctermbg=234

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
   " set formatoptions=cqt
   " set wrapmargin=0
   highlight ColorColumn ctermbg=235 guibg=#2c2d27
   highlight CursorLine ctermbg=235 guibg=#2c2d27
   highlight CursorColumn ctermbg=235 guibg=#2c2d27
   let &colorcolumn=join(range(81,999),",")
endfunction

" For fast tests quick compile current file
func! CompileGcc()
   exec "w"
   exec "!g++ % -g -std=c++11 -o %< && ./%< "
endfunc

func! CompileClang()
   exec "w"
   exec "!clang++ % -g -std=c++14 -o %< "
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

function SetupCpp()
   nnoremap <silent> <F5> <ESC>:call CompileGcc()<CR>
   inoremap <silent> <F5> <ESC>:call CompileGcc()<CR>i
   nnoremap <silent> <c-F5> <ESC>:call CompileClang()<CR>
   inoremap <silent> <c-F5> <ESC>:call CompileClang()<CR>i
endfunction

function SetupPython()
   nnoremap <silent> <F5> <ESC>:call CompilePython()<CR>
   inoremap <silent> <F5> <ESC>:call CompilePython()<CR>i
endfunction

function SetupPerl()
   nnoremap <silent> <F5> <ESC>:call CompilePerl()<CR>
   inoremap <silent> <F5> <ESC>:call CompilePerl()<CR>i
endfunction

function SetupLatex()
   nnoremap <silent> <F5> <ESC>:call CompileLatex()<CR>
   inoremap <silent> <F5> <ESC>:call CompileLatex()<CR>i
endfunction

function SetupRust()
   nnoremap <silent> <F5> <ESC>:call CompileRust()<CR>
   inoremap <silent> <F5> <ESC>:call CompileRust()<CR>i
endfunction

function SetupChuck()
   exec 'set ft=ck'
   nnoremap <silent> <F5> <ESC>:call CompileChuck()<CR>
   inoremap <silent> <F5> <ESC>:call CompileChuck()<CR>i
   nnoremap <silent> <F6> <ESC>:call ReplaceChuck()<CR>
   inoremap <silent> <F6> <ESC>:call ReplaceChuck()<CR>i
   call system("killall chuck; chuck --loop &")
endfunction

function ResetChuck()
   call system("killall chuck &")
endfunction

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
" {{{

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

" }}}

" =========================================================================
" Keyboard mappings
" =========================================================================
" {{{

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

" Duplications TODO: prevent register wipe
vnoremap <silent> ,= yP
nnoremap <silent> ,= YP

" move stuff to the right of cursor to next line
nnoremap <silent> ,<CR> i<CR><ESC>k$

" cd to the directory containing the file in the buffer
nmap <silent> ,cd :lcd %:h<CR>

" make directory
nmap <silent> ,md :!mkdir -p %:p:h<CR>

" When search done : ,n to remove highlight
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
nmap <silent> ,w :set invwrap<CR>:set wrap?<CR>

" Buffers
nnoremap <silent> ,] :bn<CR>
nnoremap <silent> ,[ :bp<CR>
nnoremap <silent> ,x :bd<CR>
nnoremap <silent> <space>] :bn<CR>
nnoremap <silent> <space>[ :bp<CR>
nnoremap <silent> <space>x :bd<CR>

" Make arrow keys not working
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <c-y>
noremap   <Down>   <c-e>
noremap   <Left>   zh
noremap   <Right>  zl

" Typos
command! W w
command! Q q

" Faster command access
" nmap <space> :
nnoremap <space>; :
nnoremap <space>w :w<CR>
nnoremap <space>q :q<CR>
nnoremap <space>wq :wq<CR>

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
nnoremap ,rtw :%s/\s\+$//e<CR>
nnoremap <space>rtw :%s/\s\+$//e<CR>

" Sudo Vim hack, write with force!
cmap w!! %!sudo tee > /dev/null %

" When entering command, press %% to quickly insert current path
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Mapping ,, to fast switch between buffers
nmap <silent> ,,<space> <c-^>

" Copy paste to + register
nmap <silent> <space>y "+yy
vmap <silent> <space>y "+y
vmap <silent> <space>p "+p
vmap <silent> <space>P "+P

" YCM
nnoremap ,yy :YcmForceCompileAndDiagnostics<CR>
nnoremap ,gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap ,gd :YcmCompleter GoToDefinition<CR>
nnoremap ,gc :YcmCompleter GoToDeclaration<CR>

" Unite
nnoremap ,t :<C-u>Unite -buffer-name=files -start-insert file_rec<cr>
nnoremap ,T :<C-u>Unite -buffer-name=files -start-insert file_rec/async:!<cr>
nnoremap ,f :<C-u>Unite -buffer-name=files -start-insert buffer file_rec/async:!<cr>
nnoremap ,b :<C-u>Unite -quick-match buffer<cr>
nnoremap ,r :<C-u>Unite -no-split -buffer-name=mru -start-insert file_mru<cr>

" }}}

" =========================================================================
" Autos
" =========================================================================
" {{{

" Programming in 80 cols
autocmd BufNewFile,BufRead *.cpp,*.h,*.c,*.py,.vimrc call Enable80CharsLimit()

" IDEs
autocmd BufNewFile,BufRead *.cpp call SetupCpp()
autocmd BufNewFile,BufRead *.py  call SetupPython()
autocmd BufNewFile,BufRead *.pl  call SetupPerl()
autocmd BufNewFile,BufRead *.tex call SetupLatex()
autocmd BufNewFile,BufRead *.rs  call SetupRust()

" Chuck
autocmd BufNewFile,BufRead *.ck call SetupChuck()
autocmd VimLeave *.ck call ResetChuck()

" Save views
" autocmd BufWinLeave * silent! mkview
" autocmd BufWinEnter * silent! loadview

" }}}
