" jd AT vauguet DOT fr
" Available at http://github.com/chikamichi/vim. Reading ":help options" is very handy here.

" This, is my beloved .vimrc config file. It's been tailored and updated for
" several years now. Thanks to everyone, anonyfamous people who contributed to
" the common knowledge on vim's internal on the Internet.
"
" I strive to comment every piece of option introduced in this file. If
" something is not clear enough, just let me know by sending an email.
" Using ":help somethingidontknowabout" is the first step, then duckduckgo it.
" Sometimes, searching in the help pages fails at retrieving the correct
" entry. Just look for it inside ":help options", it will probably show up.
"
" Some settings are particulary particular as I'm using a French Dvorak layout
" for typing (http://bepo.fr).

" {{{ Generic

" no compatibility
set nocompatible

" automatically read in external changes if we haven't modified the buffer
set autoread

" automatically flush to disk when using :make, etc.
set autowrite

" default encoding is UTF-8
set encoding=utf-8
set fileencoding=utf-8

" detect file type
filetype on

" load filetype-dependent plugins, yes, load them
filetype plugin on

" load filetypes-dependent indent rules, yes, load them as well
filetype indent on

" add : as a file-name character (allows gf to work with http://foo.bar/)
set isfname+=:

" speed up rendering in modern shells
set ttyfast

" faster!
set timeout timeoutlen=3000 ttimeoutlen=100

" faster!! do not redraw while running macros (much faster)
set lazyredraw

" I said faas-ter!!! lazy buffers
set hidden

" faster? let the OS decide when it's appropriate to flush the cache, rather than vim
set nofsync

" status line height; some plugins are big
set cmdheight=2

" use short messages, though
set shortmess=asTI

" keep some context around the cursor line
set scrolloff=3
set sidescrolloff=3

" long lines handling: wrap them, allow some more breakable characters
set wrap

" word wrapping -- don't cut words
set linebreak

" display line numbers
set number

" highlight active line
set cursorline

" backspace has the power to erase anything in any mode
set backspace=2

" no fracking *beep* sound
set noerrorbells

" no fracking screen blinking
set novisualbell

" show matching characters pair, such as ()
set showmatch

" redefining what is a default comment
set com& " reset to default
set com^=sr:*\ -,mb:*\ \ ,el:*/ com^=sr://\ -,mb://\ \ ,el:///

" enable folding
set foldenable

" folding criteria: explicit markers {{{ … }}}
set foldmethod=marker

" mouse support in terminals :)
if !has("gui_running")
  set mouse=a
  set ttymouse=xterm
endif

" don't move the cursor to the start of the line when changing buffers
set nostartofline

" don't highlight JSLint errors by default
let g:JSLintHighlightErrorLine = 0

" F2 toggles pasting mode (no auto-reindent), very handy for pasting:
" turn insert mode on, F2, paste, F2, back to normal mode
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" {{{ Spell checking

" No spell checking by default
set nospell

" But activate for .txt and .tex files.
" I mostly write .md files in English, too.
augroup filetypedetect
  au BufNewFile,BufRead *.txt setlocal spell spelllang=fr
  au BufNewFile,BufRead *.tex setlocal spell spelllang=fr
  au BufNewFile,BufRead *.md setlocal spell spelllang=en
augroup END

" Painless spell checking.
" For French, you'll need to:
"   wget http://ftp.vim.org/pub/vim/runtime/spell/fr.utf-8.sug
"   wget http://ftp.vim.org/pub/vim/runtime/spell/fr.utf-8.spl
" which you may move into ~/.vim/spell.
function s:spell_fr()
  if !exists("s:spell_check") || s:spell_check == 0
    echo "French spell checking activated."
    let s:spell_check = 1
    setlocal spell spelllang=fr
  else
    echo "Spell checking disabled."
    let s:spell_check = 0
    setlocal spell spelllang=
  endif
endfunction

" For English.
function s:spell_en()
  if !exists("s:spell_check") || s:spell_check == 0
    echo "English spell checking activated."
    let s:spell_check = 1
    setlocal spell spelllang=en
  else
    echo "Spell checking disabled."
    let s:spell_check = 0
    setlocal spell spelllang=
  endif
endfunction

noremap  <F10>        :call <SID>spell_fr()<CR>
inoremap <F10>   <C-o>:call <SID>spell_fr()<CR>
vnoremap <F10>   <C-o>:call <SID>spell_fr()<CR>
noremap  <S-F10>      :call <SID>spell_en()<CR>
inoremap <S-F10> <C-o>:call <SID>spell_en()<CR>
vnoremap <S-F10> <C-o>:call <SID>spell_en()<CR>

" Spell checking }}}

" Generic }}}

" {{{ Indentation

" First, read http://vim.wikia.com/wiki/Indenting_source_code, then
" taking previous 'filetype plugin indent on' into account, no smartindent required!

" automate indent
set autoindent

" keep the current selection when indenting (thanks cbus, this is the single
" most valuable piece of conf ever)
vnoremap < <gv
vnoremap > >gv

" spaces rather than tabulations
set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab

" < and > will hit indentation levels instead of always -4/+4
set shiftround

" some nice options for cindenting, by FOLKE
set cinoptions={.5s,+.5s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s

" enables vim to get control back to handle automated indent if using Surround
let b:surround_indent = 1

" Indent rules }}}

" {{{ Search and replace

" ignore case while searching…
set ignorecase

" …unless there is a least one upper case character
set smartcase

" circular search spanning whole files
set wrapscan

" move cursor to the current result's line
set showmatch

" highlight results
set hlsearch

" highlight while typing, too
set incsearch

" <espace> deux fois en mode normal efface les messages et les résultats de recherche
nnoremap <silent> <Space><Space> :silent noh<Bar>echo<CR>

" show chars on end of line, white spaces, tabs, etc
set list
set listchars=nbsp:·,tab:>-

" Search and replace }}}

" {{{ Status line, menus, tabs

" all… right: custom status line
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set statusline=
set statusline+=%3.3n\                       " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%1*%m%r%w%0*               " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}%{&bomb?'/bom':''}, " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%{exists('loaded_VCSCommand')?VCSCommandGetStatusLine():''} " show vcs status
set statusline+=%{exists('loaded_scmbag')?SCMbag_Info():''} " show vcs status
set statusline+=%=                           " right align
set statusline+=\[%{exists('loaded_taglist')?Tlist_Get_Tag_Prototype_By_Line(expand('%'),line('.')):'no\ tags'}]\   " show tag prototype
set statusline+=0x%-8B\                      " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

" OmniCompletion
set ofu=syntaxcomplete#Complete

" http://vimdoc.sourceforge.net/htmldoc/insert.html#ft-syntax-omni
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
             \ if &omnifunc == "" |
             \ setlocal omnifunc=syntaxcomplete#Complete |
             \ endif
endif

" show a list of all matches when tabbing a command
set wildmenu

" use tab for auto-expansion in menus
set wildchar=<TAB>

" how command line completion works
set wildmode=list:longest,list:full

" ignore some files for filename completion
set wildignore=*.o,*.r,*.so,*.sl,*.tar,*.tgz,*.pyc,*~,.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif

" some filetypes got lower priority
set suffixes=.h,.bak,~,.o,.info,.swp,.obj

" remember last 2000 typed commands
set history=2000

" display cursor position (line/column) in the status line
set ruler

" actually display more information in the ruler
set rulerformat=%40(%=%t%h%m%r%w%<\ (%n)\ %4.7l,%-7.(%c%V%)\ %P%)

" always display currently used mode
set showmode

" dynamic display of commands
set showcmd

" a - terse messages (like [+] instead of [Modified]
" o - don't show both reading and writing messages if both occur at once
" t - truncate file names
" T - truncate messages rather than prompting to press enter
" W - don't show [w] when writing
" I - no intro message when starting vim fileless
set shortmess=aotTWI

" always display status line
set laststatus=2

" display as much of the last line as possible if it's really long;
" also display unprintable characters as hex
set display+=lastline,uhex

" Status line, menus, tabs }}}

" {{{ Windows

" tabs everywhere! You'll need to edit gvim.desktop:
" http://vim.wikia.com/wiki/Launch_files_in_new_tabs_under_Unix
tab all

" minimal number of lines used for any window: as small as possible
set winminheight=0

" make all windows the same size when adding/removing windows
set noequalalways

" new windows are to be created under the current one
set splitbelow

" Windows }}}

" {{{ Save and backup

" enable backup
set backup

" backup location (must be created by hand!)
set backupdir=~/.vim/backup

" don't use a swap file (ie. save all the time asap)
set updatecount=0

" force saving with sudo when using "W"; will prompt for the password
" Ctrl+C to skip
command W w !sudo tee % > /dev/null

" create non existing directories upon saving
augroup BWCCreateDir
    au!
    autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p %:h" | redraw! | endif
augroup END

" autosave when focus is lost
autocmd BufLeave,FocusLost silent! wall

" Save and backup }}}

" {{{ Mappings

" Some mappings are defined in the Plugins section

" my <leader> key is the comma as it is at the center of bepo keyboard
" mappings
let   mapleader = ","
let g:mapleader = ","

" easily cancel hitting the leader key once
nnoremap <Leader><Leader> <Leader>

" I don't like auto-cd but I'd use a quicker opener (actually using Command-t though)
map <Leader>cd :cd %:p:h<CR>

" Tmux integration.
" Make Vim recognize xterm escape sequences for Page and Arrow
" keys, combined with any modifiers such as Shift, Control, and Alt.
" Expects tmux to be configured to use screen-256color and to have
" xterm-keys enabled.
" See http://www.reddit.com/r/vim/comments/1a29vk/_/c8tze8p
" and http://unix.stackexchange.com/questions/29907/how-to-get-vim-to-work-with-tmux-properly
if &term =~ '^screen'
  " Page keys http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/FAQ
  execute "set t_kP=\e[5;*~"
  execute "set t_kN=\e[6;*~"

  " Arrow keys http://unix.stackexchange.com/a/34723
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

" We can now map directions with modifiers!
" Go to the previous tab
map <M-Left> gT
" Go to the next tab
map <M-Right> gt

" Toggle line numbering
noremap <silent> <F11> :se number!<CR>

" Tailored navigation mappings for bepo.
" ie. en mode normal/commande, maintenir Alt et utiliser les doigts au
" repos pour des déplacements rapides, sans flèches
" éventuellement à étendre pour les modes insertion, visuel…
set winaltkeys=no
nmap <A-t> gj
nmap <A-s> l
nmap <A-e> gk
nmap <A-i> h

" in wrapped lines, enables to navigate on a per-line basis
map  <A-DOWN>        gj
map  <A-UP>          gk
imap <A-UP>   <ESC>  gki
imap <A-DOWN> <ESC>  gkj

" quicker way to save a file
nmap <leader>w :w<CR>
nmap <leader><Leader>w :W<CR>

" converts file format to/from unix
command! Unixformat :set ff=unix
command! Dosformat  :set ff=dos

" scroll upward without moving cursor
map <C-DOWN> <C-E>

" scroll downward without moving cursor
map <C-UP> <C-Y>

" handle NULL char in all modes as a no-op, except in the the insert mode
" where it will be converted to a space
imap <Nul> <Space>
map  <Nul> <Nop>
vmap <Nul> <Nop>
cmap <Nul> <Nop>
nmap <Nul> <Nop>

" Allows Ctrl+PgUp/PgDn in tmux
set t_kN=[6;*~
set t_kP=[5;*~

" Capitalizations
if (&tildeop)
  nmap gcw guw~l
  nmap gcW guW~l
  nmap gciw guiw~l
  nmap gciW guiW~l
  nmap gcis guis~l
  nmap gc$ gu$~l
  nmap gcgc guu~l
  nmap gcc guu~l
  vmap gc gu~l
else
  nmap gcw guw~h
  nmap gcW guW~h
  nmap gciw guiw~h
  nmap gciW guiW~h
  nmap gcis guis~h
  nmap gc$ gu$~h
  nmap gcgc guu~h
  nmap gcc guu~h
  vmap gc gu~h
endif

" Mappings }}}

" {{{ Plugins

" ack-grep
if exists(":Ack")
  let g:ackprg="ack-grep -H --nocolor --nogroup --column"
endif

" taglist
if exists(":Tlist")
  nmap <silent> <F7> :TlistToggle<CR>
  let Tlist_Show_One_File = 1  " Only show tags from the current file
  let Tlist_Sort_Type = 'name' " And sort them by name
endif

" fugitive
set statusline+=\ %{fugitive#statusline()}

" SuperTab
if exists(":SuperTabHelp")
  let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
  let g:SuperTabDefaultCompletionType = "context"
  let g:SuperTabCrMapping = 0

  " SuperTab integration with Omni
  let g:SuperTabDefaultCompletionType = "context"
  let g:SuperTabContextDefaultCompletionType = "<c-n>"
endif

" tabular
if exists(":Tabularize")
  nmap <Leader>c= :Tabularize/=<CR>
  vmap <Leader>c= :Tabularize/=<CR>
  nmap <Leader>c: :Tabularize/:\zs<CR>
  vmap <Leader>c: :Tabularize/:\zs<CR>
endif

" command-T
if exists(":CommandT")
  "let g:CommandTMatchWindowAtTop = 1
  let g:CommandTAcceptSelectionMap = '<C-t>'
  let g:CommandTAcceptSelectionTabMap = '<CR>'
endif

" coffee-script auto compile, folding
au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

if exists(":GundoToggle")
  " F5 toggles Gundo
  nnoremap <F5> :GundoToggle<CR>
endif

if exists(":A")
  " switch between header/code files
  map <F2> :A<CR>
endif

if exists(":TagbarOpen")
  " Tagbar toggling
  nnoremap <silent> <F9> :TagbarToggle<CR>
  let g:tagbar_autofocus = 1
endif

if exists(":TOhtml")
  " export HTML (:TOhtml) *avec CSS*
  let html_use_css = 1
endif

" Plugins }}}

" {{{ Autocmd

if has("autocmd")
  augroup augroup_autocmd
    au!

    " Get back to last known cursor position
    autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif

    " autocmd by filetype
    autocmd FileType text        setlocal textwidth=78 nocindent
    autocmd FileType html        set      formatoptions+=tl

    " by extension
    autocmd BufNewFile,BufRead *.pc            set filetype proc
    autocmd BufNewFile,BufRead *.phtm,*.phtml  set filetype php
    autocmd BufNewFile,BufRead *.asy           set filetype asy
    autocmd BufNewFile,BufRead *.rhtml,*.erb   set filetype eruby
    autocmd BufNewFile,BufRead *.less          set filetype less
    autocmd BufNewFile,BufRead *.mustache      set filetype mustache
    autocmd BufNewFile,BufRead *.ejs           set filetype=jst
    autocmd BufNewFile,BufRead /etc/nginx/sites-available/* set ft=nginx

    " strict tabulations in Makefiles
    autocmd FileType make     set noexpandtab

    " indent XML inline files
    "au FileType xml exe ":silent 1,$!tidy --input-xml yes --indent auto --utf8 2>/dev/null"
    au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

    au Filetype css exe ":set cuc cul"
    au Filetype sass exe ":set cuc cul"
  augroup END
endif

" Autocmd }}}

" {{{ Misc.

" Match Octopress/Jekyll's YAML Front Matter sections
" From http://www.codeography.com/2010/02/20/making-vim-play-nice-with-jekylls-yaml-front-matter.html
let g:jekyll_path = "/home/jd/blog"
high link jekyllYamlFrontmatter Comment
execute "autocmd BufNewFile,BufRead " . g:jekyll_path . "/* syn match jekyllYamlFrontmatter /\\%^---\\_.\\{-}---$/ contains=@Spell"

" Misc. }}}

" {{{ Syntax highlighting, colors, fonts

" That's pretty tricky: 256 colors support with custom schemes.

" use syntax highlighting whenever possible
syntax on

set background=light
colorscheme jellybeans

if &term =~ '256color'
  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screen.
  " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_Co=256
  set t_ut=
endif

" how many lines to sync backwards
syn sync minlines=10000 maxlines=10000

"" treat hamlc as haml
au BufRead,BufNewFile *.hamlc set ft=haml

" Syntax highlighting, colors, fonts }}}

" vim: set foldmethod=marker nonumber:

