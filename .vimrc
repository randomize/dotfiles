" Vimrc for my Archlinux vim

" ====== START Vundle  =====================================

set nocompatible
filetype off 
set rtp+=~/.vim/bundle/vundle/

call vundle#rc()

" let Vundle manage Vundle
Bundle 'git://github.com/gmarik/vundle.git'

" cpp/h switch
Bundle 'git://github.com/derekwyatt/vim-fswitch.git'

" creates C++ class method implementations
Bundle 'git://github.com/derekwyatt/vim-protodef.git'

" Todo plugin
Bundle 'git://github.com/neochrome/todo.vim.git'

" Shader GLSL syntax highliight
Bundle 'git://github.com/vim-scripts/glsl.vim.git'

" Git support
Bundle 'tpope/vim-fugitive'

" Super increment (see help)
Bundle 'VisIncr'

" My dear color scheme
Bundle 'molokai'

" Cool status line
Bundle 'bling/vim-airline'

" Show buffers in line
Bundle 'bling/vim-bufferline'

" Auto completion
Bundle 'Valloric/YouCompleteMe'

" Snipmate
Bundle 'SirVer/ultisnips'

"Syntax highl
Bundle 'scrooloose/syntastic.git'

" LaTeX
Bundle 'LaTeX-Box-Team/LaTeX-Box'

" Easy motion
Bundle 'Lokaltog/vim-easymotion'

" Commenting
Bundle 'tomtom/tcomment_vim'

" Misc
Bundle 'git://github.com/scrooloose/nerdtree.git'
Bundle 'L9'
Bundle 'git://github.com/tpope/vim-surround.git'

" Unite is one place search for vim, command-t, fuzzy-finder and buffer
" explorer gone
Bundle 'Shougo/vimproc.vim'
Bundle 'Shougo/unite.vim' 

" ==== SYNTAX =========================

" CSS highligt --- NOT WORKING
"Bundle 'skammer/vim-css-color.git' 

" Chuck syntax
Bundle 'https://github.com/vim-scripts/ck.vim.git'

" Pentadactyl -- SLOWPOKE
" Bundle 'dogrover/vim-pentadactyl'


filetype plugin indent on " required!

" ==== VUNDLE ===================================================





" this puts  backup to RAM, faster but risky ;)
set directory=/tmp

" Scheme
colorscheme molokai

" Cursor free positioning
set virtualedit=all

" Highlight syntax
syntax on

" Show line numbers
set nu

" Relative numbering for fast jumps
set relativenumber

" allow hidden buffers
set hidden

" Setup GVIM separately
if has("gui_running")

   " I like consolas in GUI
   set guifont=consolas\ 11


   " Set default size for GVIM
   set lines=50 columns=180

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

endif

" place a dollar sign when in change mode to indicate end
set cpoptions+=$

" Make p in Visual mode replace the selected text with the \" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" enable mouse in terminals
set mouse=a

" Remove splash on startup
set shortmess+=I

" Set spell for ru and eng
set spelllang=en,ru

" Encodings
set termencoding=utf-8
set fileencodings=utf-8,cp1251
set encoding=utf-8

" Настройки поиска
set hlsearch            " включить подсветку поиска
set smc=0               " отключить ограничение на максимальную позицию в строке при поиске
set ignorecase          " игнорировать регистр
set smartcase           " умный поиск

" Табуляция
set tabstop=3        " число пробелов для таба
set softtabstop=3    " число пробелов для таба при редактировании
set shiftwidth=3     " число пробелов для отступа при форматировании
set expandtab        " превращать табы в пробелы

" Отступы
set smartindent     " умные отступы
set autoindent

set nobackup        " Не сохранять бэкап file~
set laststatus=1    " показывать статус с именем файла только для нескольких открытых файлов
set ruler           " показывать положение курсора
set showcmd         " показывать вводимую команду
set history=50      " сохранять 50 строк истории команд

set wildmenu                     " использовать меню для завершения команд
"set wildmode=list:longest,full  " перв. табу - список и завершать самой длинной командой, по второму дополнять следующим вариантом и показывать меню
set wildmode=full
set wildignore=*.o,*.obj,*~  " игнорируемые файлы

set complete="" " Слова откуда будем завершать
set complete+=. " Из текущего буфера
set complete+=k " Из словаря
set complete+=t " из тегов

set completeopt+=menu      " Выдавать менюшку с дополнениями
"set completeopt+=menuone  " Показывать менюшку, даже если дополнение всего одно
set completeopt+=longest   " Автоматически дописывать совпадающий среди всех возможных дополнений кусок
set completeopt-=preview   " Показывать дополнительную инфу о дополнениях


""""""""" Фолдинг """"""""""
set foldmethod=syntax                  " фолдинг изначально по синтаксису

" заставить сохранять view
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" --------------------------------------------------------------------------------------------------------------------
" Русская раскладка
set keymap=russian-jcukenwin    " C-^ to switch
set iminsert=0                  " insert mode default en
set imsearch=0                  " search mode default en

" Map to <F9>
 cmap <silent> <F9> <C-^>
 imap <silent> <F9> <C-^>X<Esc>:call MyKeyMapHighlight()<CR>a<C-H>
 nmap <silent> <F9> a<C-^><Esc>:call MyKeyMapHighlight()<CR>
 vmap <silent> <F9> <Esc>a<C-^><Esc>:call MyKeyMapHighlight()<CR>gv

" Indicators
 function MyKeyMapHighlight()
  if &iminsert == 0
        hi StatusLine ctermfg=DarkBlue guifg=DarkBlue
  else
        hi StatusLine ctermfg=DarkGray guifg=DarkGray
  endif
 endfunction

call MyKeyMapHighlight()
au WinEnter * :call MyKeyMapHighlight()


" Toggle unprintable <F10>
set listchars=tab:>-,trail:·,extends:>,eol:¶
nnoremap <silent> <F10> <ESC>:set list!<CR>
inoremap <silent> <F10> <ESC>:set list!<CR>li


" ----------------------------------------------- !! NERD Tree !! ------------------------------------------------------
" Включаем NERDTree при запуске, если нет файла открытого, мапим его на F12, как тоггл
"au VimEnter *  NERDTree
function OpenNERDTree()
  execute ":NERDTree"
endfunction
command -nargs=0 OpenNERDTree :call OpenNERDTree()
nmap <F12> :NERDTreeToggle<CR>

let NERDTreeWinPos='right' " Располагаться NerdTree должно справа


" Меню кодировок
set wildmenu
    set wcm=<Tab>
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
    map <F11> :emenu Encoding.<Tab><Tab>

    menu FileFormat.UNIX         :e ++ff=unix
    menu FileFormat.DOS          :e ++ff=dos
    menu FileFormat.Mac          :e ++ff=mac
    map <S-F11> :emenu FileFormat.<Tab><Tab>



" ProtoDef плагин - уставливаем путь к вспомогательному скрипту
let g:protodefprotogetter = '/home/randy/.vim/bundle/vim-protodef/pullproto.pl'

" Удобняшки полезняшки

" Move text, but keep highlight
vnoremap > ><CR>gv
vnoremap < <<CR>gv

" move current line down one
"nnoremap <c-j> ddp
" move current line up one
"nnoremap <c-k> ddkP

" move visual block down one
"vnoremap <c-j> dp'[V']
" move visual block up one
"vnoremap <c-k> dkP'[V']

" tell VIM to always put a status line in, even if there is only one window
set laststatus=2

" cd to the directory containing the file in the buffer
nmap <silent> ,cd :lcd %:h<CR>
nmap <silent> ,md :!mkdir -p %:p:h<CR>

" Turn off that stupid highlight search
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
set showbreak=»

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
func! ReplaceChuck()
  exec "w"
  exec ":silent !chuck --remove.all"
  exec ":redraw!"
endfunc

autocmd BufRead *.py nnoremap <silent> <F5> <ESC>:call CompilePython()<CR>
autocmd BufRead *.py inoremap <silent> <F5> <ESC>:call CompilePython()<CR>i
autocmd BufRead *.pl nnoremap <silent> <F5> <ESC>:call CompilePerl()<CR>
autocmd BufRead *.pl inoremap <silent> <F5> <ESC>:call CompilePerl()<CR>i
autocmd BufRead *.cpp nnoremap <silent> <F5> <ESC>:call CompileGcc()<CR>
autocmd BufRead *.cpp inoremap <silent> <F5> <ESC>:call CompileGcc()<CR>i
autocmd BufRead *.tex nnoremap <silent> <F5> <ESC>:call CompileLatex()<CR>
autocmd BufRead *.tex inoremap <silent> <F5> <ESC>:call CompileLatex()<CR>i
autocmd BufRead *.ck exec 'set ft=ck'
autocmd BufRead *.ck nnoremap <silent> <F5> <ESC>:call CompileChuck()<CR>
autocmd BufRead *.ck inoremap <silent> <F5> <ESC>:call CompileChuck()<CR>i
autocmd BufRead *.ck nnoremap <silent> <F6> <ESC>:call ReplaceChuck()<CR>
autocmd BufRead *.ck inoremap <silent> <F6> <ESC>:call ReplaceChuck()<CR>i
autocmd BufRead *.ck call system("killall chuck; chuck --loop &")
autocmd VimLeave *.ck call system("killall chuck &")



" System default for mappings is now the ',' character
let mapleader = ","

" Infasters
nmap <space> :

" Search the current file for the word under the cursor and display matches
nmap <silent> ,gw :vimgrep /<C-r><C-w>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

" Edit the vimrc file
nmap <silent> ,ev :e $MYVIMRC<CR>
nmap <silent> ,sv :so $MYVIMRC<CR>

" Y янкает от курсора и до конца строки. На манер страндартных D и С.
nnoremap Y y$

" Disable ex-mode toggle
nnoremap Q <nop>

" Remove trailings
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

"set foldtext=v:folddashes.substitute(getline(v:foldstart-1),'/\\*\\\|\\*/\\\|{{{\\d\\=','','g')
filetype plugin on
filetype indent on


" Sudoing in vim hack, write with forrce!
cmap w!! %!sudo tee > /dev/null %

" When entering command, press %% to quickly insert current path
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Mapping ,, to fast switch between buffers
nmap <silent> ,,<space> <c-^>


" =========================================================================
" PLUGINS
" =========================================================================


" == Syntastic ==

" Syntastic to understand C++11
"let g:syntastic_cpp_compiler_options="-std=c++11"


" == Unite ==

" Автоматический insert mode
let g:unite_enable_start_insert = 1

" Отображаем Unite в нижней части экрана
let g:unite_split_rule = "botright"

" Отключаем замену статус строки
let g:unite_force_overwrite_statusline = 0

" Размер окна Unite
let g:unite_winheight = 10

" Nice arrows
let g:unite_candidate_icon="▷"

" Make unite file list(<,t>) ignore .gitignore(depends on ag)
let g:unite_source_rec_async_command= 'ag --nocolor --nogroup --hidden -g ""'

nnoremap <leader>f :<C-u>Unite -buffer-name=files -start-insert buffer file_rec/async:!<cr>
nnoremap <leader>t :Unite file_rec/async -start-insert<cr>
nnoremap <leader>b :Unite -quick-match buffer<cr>
nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru -start-insert file_mru<cr>

"" Unite
"let g:unite_source_history_yank_enable = 1
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
"nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
"nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
"nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
"nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
"nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
"nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>
"
"" Custom mappings for the unite buffer
"autocmd FileType unite call s:unite_settings()
"function! s:unite_settings()
"  " Play nice with supertab
"  let b:SuperTabDisabled=1
"  " Enable navigation with control-j and control-k in insert mode
"  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
"  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
"endfunction

"== Chuck ==
"let g:syntastic_ck_chuck_exec="/cygdrive/c/Program\ Files\ \(x86\)/ChucK/bin/chuck.exe"

" == You complete me ==

" Use default config
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" == Ultisnips ==

" Remap to not conflict with
"let g:UltiSnipsExpandTrigger="<nop>"
"let g:UltiSnipsJumpForwardTrigger="<nop>"
"let g:UltiSnipsJumpBackwardTrigger="<nop>"

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
