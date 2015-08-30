" Vim config
"   vim: foldmethod=marker
"
"   TODO:
"
"   1) play with args and argdo commands (like :args `ag -l foo`)
"   2) quickfix commands (go, t, i etc)
"   3) Unite setup
"   4) unimpaired keys learn
"   5) vim-multiple-cursors
"   6) vim-easy-align
"   7) vim-operator-user
"
" =========================================================================
" Vundle
" =========================================================================
" {{{
"


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
" Plugin 'vitalk/vim-simple-todo'

" Git support
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Super increment
Plugin 'VisIncr'

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

" Unite - obsoletes: command-t, fuzzy-finder, buffer explorer and perhaps ctrlP
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/unite.vim'
Plugin 'ujihisa/unite-colorscheme'

" Indent guides
Plugin 'nathanaelkane/vim-indent-guides'

" Tabling
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'godlygeek/tabular'

" Status line
Plugin 'bling/vim-airline'

" Session save/restore
Plugin 'xolox/vim-session'
Plugin 'xolox/vim-misc'

" Undo visual tree
" Plugin 'sjl/gundo.vim' " Older one
Plugin 'mbbill/undotree'

" Tags for C++/C and others
Plugin 'majutsushi/tagbar'

" Formatting with clanfg format
Plugin 'rhysd/vim-clang-format'

" Taglist
Plugin 'vim-scripts/taglist.vim'

" Rainbow prentheses
Plugin 'kien/rainbow_parentheses.vim'

" ==== SYNTAX =========================

Plugin 'vim-scripts/ck.vim'
Plugin 'vim-scripts/glsl.vim'
Plugin 'vim-scripts/cg.vim'
Plugin 'leshill/vim-json'
Plugin 'chrisbra/csv.vim'
Plugin 'dag/vim2hs'
Plugin 'tpope/vim-markdown'
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'vim-scripts/octave.vim--'
Plugin 'vim-perl/vim-perl'
Plugin 'wting/rust.vim'
Plugin 'andersoncustodio/vim-tmux'
Plugin 'vim-scripts/Logcat-syntax-highlighter'

" ==== Other ==========================

Plugin 'L9'
Plugin 'tpope/vim-surround'
Plugin 'mileszs/ack.vim'
Plugin 'terryma/vim-expand-region'

Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-vinegar'
Plugin 'vim-scripts/restore_view.vim'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-unimpaired'
" Plugin 'Raimondi/delimitMate' " ==== breaks repeat, and makes noise!!!
Plugin 'mhinz/vim-startify'
Plugin 'xuhdev/SingleCompile'

" === C# and Uniy =====================
Plugin 'OmniSharp/omnisharp-vim'
Plugin 'OrangeT/vim-csharp'

"===== Themes =========================
" Plugin 'chriskempson/base16-vim' ==== still prefer molokai
Plugin 'tomasr/molokai'
Plugin 'sjl/badwolf'
Plugin 'jordwalke/flatlandia'
Plugin 'morhetz/gruvbox'

" ==== Obsolete  =====================

" Plugin 'mkitt/tabline.vim'      " Buildin into airline
" Plugin 'bling/vim-bufferline'   " Deprecated since tabline buffer support
" Plugin 'Lokaltog/vim-powerline' " Using airline

call vundle#end()
filetype plugin indent on

" }}}


" =========================================================================
" Colors (should precede colorscheme command)
" =========================================================================
" {{{

" Show whitespace
" autocmd ColorScheme * highlight ExtraWhitespace ctermbg=124 guibg=red
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" }}}

" =========================================================================
" OS Detector and global swithches
" =========================================================================
" {{{


if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

if !exists("g:bully_dev")
    let g:bully_dev = "Eugene"
    " let g:bully_dev = "Dmitry"
    " let g:bully_dev = "Shag"
endif

" }}}
"
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
" set background=dark
let g:rehash256 = 1
colorscheme molokai
" let base16colorspace=256
" colorscheme base16-default
" colorscheme base16-tomorrow

" Cursor free positioning
if g:bully_dev == "Eugene"
    set virtualedit=all
endif

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
set noshowmode     " Mode is in airline, no need stock one
set ttyfast        " Term is fast

set formatoptions-=t " Don't wrap while typing
set cmdwinheight=16  " Command-line window
set vb t_vb=


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
set timeoutlen=1000

" Backups
set directory=/tmp  " Risky but fast

set backup
set writebackup
" set backupskip=/tmp/*
set backupdir=/tmp

set undofile
set undodir=/tmp

" History depth
set history=256
set undolevels=256

" Search
set hlsearch     " Highlight search results
set ignorecase   " no sensitive to case
set smartcase    " When meet uppercase -> sensitive
set incsearch

" Tabs ans indentation
set tabstop=4       " Tab size
set softtabstop=4   " Tab size in inset mode
set shiftwidth=4    " <> shift size
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

" View options
set viewoptions=cursor,options,folds,slash,unix

" System default for mappings is now the ',' character
let mapleader = ","

" Setup GVIM separately
if has("gui_running")

    if g:os == "Darwin"
        set guifont=PragmataPro:h14
    elseif g:os == "Linux"
        set guifont=PragmataPro\ 12
    elseif g:os == "Windows"
        " TODO: Windows here
    endif

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

   " Italic comments
   if g:os == "Linux"
       highlight Comment cterm=italic
   endif

   " TODO: cursor play with blinking

endif
" }}}

" =========================================================================
" Plugin settings
" =========================================================================
" {{{

" == startify ===============
let g:startify_bookmarks = ['~/.vimrc','~/.zshrc','~/nfo/commands.txt',]
let g:startify_custom_header =
 \ map(split(system('fortune | cowsay -W 60'), '\n') , '"   ". v:val') + ['','']
  " \ split(system('fortune | cowsay -W 60'), '\n') + ['','']
let g:startify_change_to_dir = 0
let g:startify_files_number = 8

" === Clang Format ==
"  "AllowShortIfStatementsOnASingleLine" : "true",
"  "AlwaysBreakTemplateDeclarations" : "true",
" Now uses ~/.clang-format file, no need to define settings here

" == gundo/undotree ==

" Make bigger
let g:undotree_SplitWidth = 40

" == restore_view===

" let g:skipview_files = ['*\.vim']

" == session ==

let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

" == Indent guides ==

let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 0

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=darkgrey ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgrey ctermbg=235

" == ProtoDef ==

let g:protodefprotogetter = '/home/randy/.vim/bundle/vim-protodef/pullproto.pl'

" == Airline / Powerline  ==

" bufferline
" let g:bufferline_modified = '*'
" let g:bufferline_echo = 0
" let g:Powerline_symbols="fancy"

let g:airline_theme='powerlineish'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline#extensions#tabline#show_buffers = 1

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
let g:ycm_auto_trigger = 1

" let g:ycm_key_invoke_completion = '<c-Tab>'
let g:ycm_key_list_select_completion = ['<tab>', '<up>']
"let g:ycm_key_list_previous_completion = ['<s-tab>']
"
let g:ycm_extra_conf_globlist = ['~/rdev/cpp/*']

" Disable for latex
let g:ycm_filetype_blacklist = {
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'text' : 1,
      \ 'tex' : 1,
      \}

" === LaTeX Box =====================
let g:LatexBox_viewer = 'zathura'
let g:LatexBox_latexmk_options = '-pvc -pdflatex="pdflatex -shell-escape"'

" == Ultisnips ==
" let g:UltiSnipsListSnippets="<F3>"
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

let g:UltiSnipsEditSplit="vertical"

" == Ack ===

let g:ackprg = 'ag --nogroup --nocolor --column'

" == TODO plugin ===
" todo.vim default highlight groups, feel free to override as wanted
hi link TodoTitle Title
hi link TodoTitleMark Normal
hi link TodoItem Special
hi link TodoItemAdditionalText Comment
hi link TodoItemCheckBox Identifier
hi link TodoItemDone Ignore
hi link TodoComment Comment

" define like this to enable explicit comments
" comments then start with //
let g:TodoExplicitCommentsEnabled = 1

" == OmniSharp ===
let g:Omnisharp_start_server = 0
let g:Omnisharp_stop_server  = 0
let g:OmniSharp_host="http://localhost:20001"
let g:ycm_csharp_server_port = 20001
let g:OmniSharp_timeout = 1

" }}}

" =========================================================================
" Helper functions
" =========================================================================
" {{{

function! Enable80CharsLimit()
   set colorcolumn=80
   set textwidth=80
   " set formatoptions=cqt
   " set wrapmargin=0
   highlight ColorColumn ctermbg=235 guibg=#2c2d27
   highlight CursorLine ctermbg=235 guibg=#2c2d27
   highlight CursorColumn ctermbg=235 guibg=#2c2d27
   let &colorcolumn=join(range(81,999),",")
endfunction


" Translator with sdcv
function! TRANSLATE()
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

function! KbdLayoutState()
   if &iminsert == 0
      return 'en'
   else
      return 'ru'
   endif
endfunction

call airline#parts#define_function('bikeystat', 'KbdLayoutState')
let g:airline_section_a = airline#section#create(['mode', ' [', 'bikeystat', ']'])

function! FindProjectRoot(lookFor)
    let pathMaker='%:p'
    while(len(expand(pathMaker))>len(expand(pathMaker.':h')))
        let pathMaker=pathMaker.':h'
        let fileToCheck=expand(pathMaker).'/'.a:lookFor
        if filereadable(fileToCheck)||isdirectory(fileToCheck)
            return expand(pathMaker).'/'.a:lookFor
        endif
    endwhile
    return 0
endfunction

" Build the ctrlp function, using projectroot to define the
" working directory.
function! Unite_ctrlp()
  execute ':Unite  -buffer-name=files -start-insert buffer file_rec/async:'.fnameescape(FindProjectRoot("Assets")).'/'
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

" Single compile binding
nmap <silent> <F5> <ESC>:SCCompile<CR>
nmap <silent> <F6> <ESC>:SCCompileRun<CR>

" Translator function
nmap <F3>  :call TRANSLATE()<cr>
imap <F3>  <c-o>:call TRANSLATE()<cr>

" Session workflow
nmap <leader>so :OpenSession<space>
nmap <leader>ss :SaveSession<space>
nmap <leader>sd :DeleteSession<CR>
nmap <leader>sc :CloseSession<CR>

" Toggle spelling with the F7 key
nmap <silent> <F7> <ESC>:setlocal spell!<CR>
imap <silent> <F7> <c-o>:setlocal spell!<CR>

" Toggle keyboard layout
imap <silent> <F9> <C-^>

" Toggle unprintable <F10>
nmap <silent> <F10> <ESC>:set list!<CR>
imap <silent> <F10> <c-o>:set list!<CR>

nmap <F11> :emenu Encoding.<Tab><Tab>
nmap <S-F11> :emenu FileFormat.<Tab><Tab>

" Toggle things
" nmap <leader>1 :GundoToggle<CR>
nmap <leader>1 :UndotreeToggle<CR>
set pastetoggle=<leader>2
nmap <leader>3 :TlistToggle<CR>
nmap <leader>4 :TagbarToggle<CR>
nmap <leader>5 :NERDTreeToggle<CR>

" Make p in Visual mode replace the selected text with the \" register.
vmap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Indentation changes, but visual stays
vnoremap > ><CR>gv
vnoremap < <<CR>gv

" move current line up/down one
nmap <c-j> ddp
nmap <c-k> ddkP

" move visual block up/down one
vmap <c-j> dp'[V']
vmap <c-k> dkP'[V']

" Duplications
" TODO: prevent register wipe
vmap <silent> <leader>= yP
nmap <silent> <leader>= YP

" move stuff to the right of cursor to next line
nmap <silent> <leader><CR> i<CR><ESC>k$

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" make directory
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" When search done : ,n to remove highlight
nmap <silent> <leader>n :nohls<CR>

" Alright... let's try this out
imap jj <esc>

" Line wrap toggle
nmap <silent> <leader>w :set invwrap<CR>:set wrap?<CR>

" Buffers
nmap <silent> <leader>] :bn<CR>
nmap <silent> <leader>[ :bp<CR>
nmap <silent> <leader>c :bd<CR>

" Faster command access
nmap <silent> <space> <NOP>
nmap <space>;  :
nmap <space><space>  :
nmap <silent> <space>w  :w<CR>
" nmap <silent> <space>ww :w<CR>
nmap <silent> <space>q  :q<CR>
" nmap <silent> <space>wq :wq<CR>
" nmap <silent> <space>wc :w<CR>:bd<CR>
nmap <silent> <space>]  :bn<CR>
nmap <silent> <space>[  :bp<CR>
nmap <silent> <space>c  :bd<CR>

" Remove trailing whitespaces
nmap <silent> <leader>rtw :%s/\s\+$//e<CR>:nohl<CR>

" Copy paste to + register
nmap <silent> <space>y "+yy
vmap <silent> <space>y "+y
nmap <silent> <space>p "+p
nmap <silent> <space>pp "*p
nmap <silent> <space>P "+P
nmap <silent> <space>PP "*P


" Search the current file for the word under the cursor and display matches
nmap <silent> <leader>gw :vimgrep /<C-r><C-w>/ %<CR>:ccl<CR>:cwin<CR><C-W>J:nohls<CR>

" Edit the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Yank to end (like D and C)
nmap Y y$

" Sudo Vim hack, write with force! (Good guys use sudoedit for this)
" cmap w!! %!sudo tee > /dev/null %

" When entering command, press %% to quickly insert current path
cmap %% <C-R>=expand('%:h').'/'<cr>

" Mapping ,, to fast switch between buffers
nmap <silent> <leader><leader><space> <c-^>

" Tab in normal mode is useless - use it to %
nmap <Tab> %
vmap <Tab> %

" Ack on ,a
nmap <leader>a :Ack<space>

vmap v <Plug>(expand_region_expand)
vmap <c-v> <Plug>(expand_region_shrink)


" === YCM =====
nmap <leader>yy :YcmForceCompileAndDiagnostics<cr>
nmap <leader>yg :YcmCompleter GoToDefinitionElseDeclaration<cr>
nmap <leader>yd :YcmCompleter GoToDefinition<cr>
nmap <leader>yc :YcmCompleter GoToDeclaration<cr>
nmap <leader>yt :YcmCompleter GetType<cr>


" == Unite =====
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])

nnoremap <leader>uf :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async <cr>

nnoremap <leader>ut :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <leader>ur :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>uo :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>uy :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <leader>ub :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>
nnoremap <leader>ul :<C-u>Unite -buffer-name=lines  line<cr>
nnoremap <leader>uc :<C-u>Unite colorscheme<cr>
nnoremap <leader>uh :<C-u>Unite history/yank<cr>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction


" == Fugitive =======
noremap <leader>gd :Gdiff<CR>
noremap <leader>gc :Gcommit<CR>
noremap <leader>gs :Gstatus<CR>
noremap <leader>gw :Gwrite<CR>
noremap <leader>gb :Gblame<CR>


" }}}


" =========================================================================
" Filetype speicific
" =========================================================================
" {{{

function! SetupLatex()

    call Enable80CharsLimit()

    " Add triggers to ycm for LaTeX-Box autocompletion
    let g:ycm_semantic_triggers = {
    \  'tex'  : ['{'],
    \ }

endfunction

function! SetupCpp()

    call Enable80CharsLimit()
    :IndentGuidesEnable

    " Clang formar
    nnoremap <buffer>,cf :<C-u>ClangFormat<CR>
    vnoremap <buffer>,cf :ClangFormat<CR>

    call SingleCompile#ChooseCompiler('cpp', 'clang')

    nmap <buffer> <F5> :SCCompileAF -O0 -ggdb -std=c++11 -stdlib=libc++ -lc++abi -lpthread<cr>
    nmap <buffer> <F6> :SCCompileRunAF -O0 -ggdb -std=c++11 -stdlib=libc++ -lc++abi -lpthread<cr>

    " FSwitch mappings
    nmap <silent> <leader>of :FSHere<CR>
    nmap <silent> <leader>ol :FSRight<CR>
    nmap <silent> <leader>oL :FSSplitRight<CR>
    nmap <silent> <leader>oh :FSLeft<CR>
    nmap <silent> <leader>oH :FSSplitLeft<CR>
    nmap <silent> <leader>ok :FSAbove<CR>
    nmap <silent> <leader>oK :FSSplitAbove<CR>
    nmap <silent> <leader>oj :FSBelow<CR>
    nmap <silent> <leader>oJ :FSSplitBelow<CR>


endfunction

function! SetupCs()

    call Enable80CharsLimit()
    :IndentGuidesEnable

    " == Unite ===
    nnoremap <leader>uf :call Unite_ctrlp()<cr>

    " == Omnisharp ===
    nnoremap <leader>sd :OmniSharpGotoDefinition<cr>
    nnoremap <leader>si :OmniSharpFindImplementations<cr>
    nnoremap <leader>st :OmniSharpFindType<cr>
    nnoremap <leader>ss :OmniSharpFindSymbol<cr>
    nnoremap <leader>su :OmniSharpFindUsages<cr>
    nnoremap <leader>sm :OmniSharpFindMembers<cr>
    nnoremap <leader>sx  :OmniSharpFixIssue<cr>
    nnoremap <leader>sxu :OmniSharpFixUsings<cr>
    nnoremap <leader>st :OmniSharpTypeLookup<cr>
    nnoremap <leader>sd :OmniSharpDocumentation<cr>
    nnoremap <leader>sk :OmniSharpNavigateUp<cr>
    nnoremap <leader>sj :OmniSharpNavigateDown<cr>
    nnoremap <leader>sl :OmniSharpReloadSolution<cr>
    nnoremap <leader>sf :OmniSharpCodeFormat<cr>
    nnoremap <leader>sa :OmniSharpAddToProject<cr>

    " Contextual code actions (requires CtrlP or unite.vim)
    nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
    " Run code actions with text selected in visual mode to extract method
    vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

    " rename with dialog
    nnoremap <leader>sr :OmniSharpRename<cr>
    " rename without dialog - with cursor on the symbol to rename... ':Rename newname'
    command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

    " (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
    nnoremap <leader>ss :OmniSharpStartServer<cr>
    nnoremap <leader>sp :OmniSharpStopServer<cr>

    " Add syntax highlighting for types and interfaces
    nnoremap <leader>sh :OmniSharpHighlightTypes<cr>

endfunction

function! SetupPython()

    call Enable80CharsLimit()
    :IndentGuidesEnable

endfunction

" =========================================================================
" Autos
" =========================================================================
" {{{

" Working in 80 cols
autocmd BufNewFile,BufRead .vimrc,.zshrc call Enable80CharsLimit()


" IDEs
autocmd BufNewFile,BufRead *.cpp,*.h,*.c call SetupCpp()
autocmd BufNewFile,BufRead *.py  call SetupPython()
autocmd BufNewFile,BufRead *.tex call SetupLatex()
autocmd BufNewFile,BufRead *.cs call SetupCs()

" }}}
