" jd AT vauguet DOT fr
" available at http://github.com/chikamichi/config-files or /vim

" {{{ Generic

" no compatibility
set nocp

" automatically read in external changes if we haven't modified the buffer
set autoread

" automatically flush to disk when using :make, etc.
set autowrite

" default encoding
set encoding=utf-8
set fileencoding=utf-8

" detect the type of file
filetype on

" load filetype plugins
filetype plugin on

" load indent files for specific filetypes
filetype indent on

" add : as a file-name character (allows gf to work with http://foo.bar/)
set isfname+=:

" speed up rendering in modern shells
set ttyfast

" faster!
set timeout timeoutlen=3000 ttimeoutlen=100

" faster!! do not redraw while running macros (much faster)
set lazyredraw

" I said faster!!! lazy buffers
set hidden

" faster!!! let the OS decide when it's appropriate to flush the cache, rather than vim
set nofsync

" hauteur de la ligne de status (utile pour les plugins de library hints,
" notifications diverses et variées type mlint, VCS…)
set ch=2

" utiliser des messages plus courts de la part de Vim
set shortmess=asTI

" conserve du contexte autour du curseur d'édition
set scrolloff=3
set sidescrolloff=3

" gestion des lignes longues (:help wrap)
set wrap
set sidescroll=5
set listchars+=precedes:<,extends:>

" affiche les numéros de ligne sur le coté
set nu!

" met en évidence la ligne actuellement éditée
set cursorline

" la touche backspace peut supprimer tout et n'importe quoi, *dans tous les modes*
set backspace=2

" *pas de bip* relou lors d'une erreur
set noerrorbells

" ne *pas* faire clignoter l'écran lors d'une erreur (relou^2)
set novisualbell

" quand on tape par ex. un ")", Vim montre brièvement le "(" correspondant
set showmatch

" définitions de ce que sont les commentaires par défaut
set com& " reset to default
set com^=sr:*\ -,mb:*\ \ ,el:*/ com^=sr://\ -,mb://\ \ ,el:///

" autorise le folding
set foldenable

" critère par défaut pour replier les blocs : marqueurs explicites {{{ … }}}
set foldmethod=marker

" mouse support in terminals :)
if !has("gui_running")
  set mouse=a
  set ttymouse=xterm
endif

" show chars on end of line, white spaces, tabs, etc
set list

" don't move the cursor to the start of the line when changing buffers
set nostartofline

" don't highlight JSLint errors
let g:JSLintHighlightErrorLine = 0

" F2 toggles pasting mode (no auto-reindent)
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" F5 toggles Gundo
nnoremap <F5> :GundoToggle<CR>

" {{{ correction orthographique

" pas de correction orthographique par défaut
set nospell

" automatique pour les fichiers .txt et .tex
augroup filetypedetect
  au BufNewFile,BufRead *.txt setlocal spell spelllang=fr
  au BufNewFile,BufRead *.tex setlocal spell spelllang=fr
augroup END

" painless spell checking
" for French, you'll need
" wget http://ftp.vim.org/pub/vim/runtime/spell/fr.utf-8.sug
" wget http://ftp.vim.org/pub/vim/runtime/spell/fr.utf-8.spl
" which you may move into ~/.vim/spell
function s:spell_fr()
  if !exists("s:spell_check") || s:spell_check == 0
    echo "Correction orthographique activée (français)"
    let s:spell_check = 1
    setlocal spell spelllang=fr
  else
    echo "Correction orthographique désactivée"
    let s:spell_check = 0
    setlocal spell spelllang=
  endif
endfunction
" for English
function s:spell_en()
  if !exists("s:spell_check") || s:spell_check == 0
    echo "Correction orthographique activée (anglais)"
    let s:spell_check = 1
    setlocal spell spelllang=en
  else
    echo "Correction orthographique désactivée"
    let s:spell_check = 0
    setlocal spell spelllang=
  endif
endfunction

" mapping français
noremap  <F10>        :call <SID>spell_fr()<CR>
inoremap <F10>   <C-o>:call <SID>spell_fr()<CR>
vnoremap <F10>   <C-o>:call <SID>spell_fr()<CR>
" mapping English
noremap  <S-F10>      :call <SID>spell_en()<CR>
inoremap <S-F10> <C-o>:call <SID>spell_en()<CR>
vnoremap <S-F10> <C-o>:call <SID>spell_en()<CR>

" correction orthographique }}}

" Generic }}}

" {{{ Indentation

" à lire avant tout copier/coller stupide : http://vim.wikia.com/wiki/Indenting_source_code
" compte tenu du 'filetype plugin indent on' précédent, pas de smartindent !

" indentation automatique en l'absence de réglages pour le filetype courant
set autoindent

" keep the current selection when indenting (thanks cbus)
vnoremap < <gv
vnoremap > >gv

" des espaces à la place du caractère TAB
set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab

" < and > will hit indentation levels instead of always -4/+4
set shiftround

" some nice options for cindenting, by FOLKE
set cinoptions={.5s,+.5s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s

" {{{ pour le plugin surround
" permet de redonner la main à vim pour gérer l'indentation automatique
let b:surround_indent = 1
" surround }}}

" Indentation }}}

" {{{ Recherche et substitution

" ignorer la casse des caractères dans les recherches de chaînes
set ignorecase

" mais ne pas l'ignorer s'il y a explicitement des majuscules
set scs

" regexp en version magic
set magic

" recherche circulaire (pour couvrir tout le fichier, quel que soit le point
" de départ de la recherche)
set wrapscan

" résultats dynamiques au cours de la recherche (amène le curseur sur le
" résultat pour le motif actuellement recherché)
set sm

" surlignage des résultats
set hls

" … y compris en cours de frappe
set incsearch

" <espace> deux fois en mode normal efface les messages et les résultats de recherche
nnoremap <silent> <Space><Space> :silent noh<Bar>echo<CR>

" expliciter les espaces insécables et tabulations
set listchars=nbsp:·,tab:>-
set list

" Recherche et subsitution }}}

" {{{ Statusline, menu, onglets

" all… right
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

" SuperTab integration with Omni
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" http://vimdoc.sourceforge.net/htmldoc/insert.html#ft-syntax-omni
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
             \ if &omnifunc == "" |
             \ setlocal omnifunc=syntaxcomplete#Complete |
             \ endif
endif

" use tab for auto-expansion in menus
set wc=<TAB>

" show a list of all matches when tabbing a command
set wmnu

" how command line completion works
set wildmode=list:longest,list:full

" ignore some files for filename completion
set wildignore=*.o,*.r,*.so,*.sl,*.tar,*.tgz,*.pyc,*~,.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif

" some filetypes got lower priority
set su=.h,.bak,~,.o,.info,.swp,.obj

" enhanced command-line completion mode
set wildmenu

" remember last 2000 typed commands
set hi=2000

" afficher la position du curseur
set ruler

" display more information in the ruler
set rulerformat=%40(%=%t%h%m%r%w%<\ (%n)\ %4.7l,%-7.(%c%V%)\ %P%)

" toujours afficher le mode courant
set showmode

" affichage dynamique des commandes
set showcmd

" a - terse messages (like [+] instead of [Modified]
" o - don't show both reading and writing messages if both occur at once
" t - truncate file names
" T - truncate messages rather than prompting to press enter
" W - don't show [w] when writing
" I - no intro message when starting vim fileless
set shortmess=aotTWI

" la ligne de status est toujours visible
set laststatus=2

" display as much of the last line as possible if it's really long
" also display unprintable characters as hex
set display+=lastline,uhex

" word wrapping -- don't cut words
set linebreak

" Statusline, menu, onglets }}}

" {{{ Gestion du fenêtrage (GVim)

" tabs everywhere!
" you'll need to edit gvim.desktop:
" http://vim.wikia.com/wiki/Launch_files_in_new_tabs_under_Unix
tab all

" minimal number of lines used for the current window
set wh=1

" minimal number of lines used for any window
set wmh=0

" make all windows the same size when adding/removing windows
set noequalalways

" les nouvelles fenêtres sont crées sous l'actuelle
set splitbelow

" Gestion du fenêtrage }}}

" {{{ Sauvegarde

" activation du backup
set backup

" répertoire de backup
set backupdir=~/.vim/backup

" le swap est mis à jour aprés 50 caractères saisies
"set updatecount=500
" suppression de l'utilisation du fichier d'échange
set updatecount=0

" force save with sudo when using "W"
command W w !sudo tee % > /dev/null

" create non existing directories upon saving
augroup BWCCreateDir
    au!
    autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p %:h" | redraw! | endif
augroup END

" autosave when focus is lost
autocmd BufLeave,FocusLost silent! wall


" Sauvegarde }}}

" {{{ Mappings
" certains mappings sont définis dans la section Plugins

" modifie le <leader> (« \ » par défaut)
" j'utilise la virgule car sur le clavier bépo, elle est située en plein
" centre du clavier !
let   mapleader = ","
let g:mapleader = ","

" easily cancel hitting the leader key once
nnoremap <Leader><Leader> <Leader>

" pratique pour ouvrir des fichiers, à défaut d'un auto-cd
map <Leader>cd :cd %:p:h<CR>

" Need to add this within ~/.Xdefaults
"! Alt + arrow keys should behave as they do in xterm for vim to catch them
"URxvt.keysym.M-Down:        \033[1;3B
"URxvt.keysym.M-Up:          \033[1;3A
"URxvt.keysym.M-Left:        \033[1;3D
"URxvt.keysym.M-Right:       \033[1;3C
" previous tab
map <M-Left> gT
" next tab
map <M-Right> gt

" Toggle line numbering
noremap <silent> <F11> :se nu!<CR>

" navigation spéciale clavier bépo (dvorak) -- bepo.fr
" ie. en mode normal/commande, maintenir Alt et utiliser les doigts au
" repos pour des déplacements rapides, sans flèches
" éventuellement à étendre pour les modes insertion, visuel…
set winaltkeys=no
nmap <A-t> gj
nmap <A-s> l
nmap <A-e> gk
nmap <A-i> h

" navigation alternatives dans les lignes coupées
map  <A-DOWN>        gj
map  <A-UP>          gk
imap <A-UP>   <ESC>  gki
imap <A-DOWN> <ESC>  gkj

" sauvegarde rapide
nmap <leader>w :w<CR>
nmap <leader><Leader>w :W<CR>

" converts file format to/from unix
command! Unixformat :set ff=unix
command! Dosformat  :set ff=dos

" scroll vers le bas sans bouger le curseur
"map <C-DOWN> <C-E>
" scroll vers le haut sans bouger le curseur
"map <C-UP> <C-Y>

" tout séléctionner
"noremap <C-A> gggH<C-O>G
"cnoremap <C-A> <C-C>gggH<C-O>G

" <F1> lance la commande d'aide au lieu d'afficher l'intro de l'aide
nnoremap <F1> :help<Space>
vmap <F1> <C-C><F1>
omap <F1> <C-C><F1>
map! <F1> <C-C><F1>

" forcer la fermeture d'un tampon avec <F4>
map  <F4> :bd!<cr>
imap <F4> <C-O>:bd!<cr>
cmap <F4> <c-c>:bd!<cr>

" gestion du caractère NULL dans tous les modes
imap <Nul> <Space>
map  <Nul> <Nop>
vmap <Nul> <Nop>
cmap <Nul> <Nop>
nmap <Nul> <Nop>

" switch between header/code files
map <F2> :A<CR>

" Tagbar toggling
nnoremap <silent> <F9> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Allow Ctrl+PgUp/PgDn in tmux
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

" interesting ones but not tested yet:
" - coding styles per project: http://www.vim.org/scripts/script.php?script_id=2633

" see README.md for instructions on installing plugins
call pathogen#helptags()
call pathogen#infect()

" ack-grep
" https://github.com/mileszs/ack.vim
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" taglist
nmap <silent> <F7> :TlistToggle<CR>
let Tlist_Show_One_File = 1  " Only show tags from the current file
let Tlist_Sort_Type = 'name' " And sort them by name

" fugitive
set statusline+=\ %{fugitive#statusline()}

" supertab
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabCrMapping = 0

" tabular
if exists(":Tabularize")
  nmap <Leader>c= :Tabularize/=<CR>
  vmap <Leader>c= :Tabularize/=<CR>
  nmap <Leader>c: :Tabularize/:\zs<CR>
  vmap <Leader>c: :Tabularize/:\zs<CR>
endif

" command-T
let g:CommandTMatchWindowAtTop = 1
let g:CommandTAcceptSelection = '<C-t>'
let g:CommandTAcceptSelectionTabMap = '<CR>'

" coffee-script auto compile, folding
au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

" Plugins }}}

" {{{ Commandes automatiques

if has("autocmd")
  augroup augroup_autocmd
    au!

    " se placer à la position du curseur lors de la fermeture du fichier
    autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif

    " par type de fichier
    autocmd FileType text        setlocal textwidth=78 nocindent
    autocmd FileType html        set      formatoptions+=tl

    " par extension, pour les cas tricky
    autocmd BufNewFile,BufRead *.pc            set filetype proc
    autocmd BufNewFile,BufRead *.phtm,*.phtml  set filetype php
    autocmd BufNewFile,BufRead *.asy           set filetype asy
    autocmd BufNewFile,BufRead *.rhtml,*.erb   set filetype eruby
    autocmd BufNewFile,BufRead *.less          set filetype less
    autocmd BufNewFile,BufRead *.mustache      set filetype mustache
    autocmd BufNewFile,BufRead *.ejs           set filetype=jst
    autocmd BufNewFile,BufRead /etc/nginx/sites-available/* set ft=nginx

    " tabulation stricte dans les Makefile
    autocmd FileType make     set noexpandtab

    " indent XML inline files
    "au FileType xml exe ":silent 1,$!tidy --input-xml yes --indent auto --utf8 2>/dev/null"
    au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

    au Filetype css exe ":set cuc cul"
    au Filetype sass exe ":set cuc cul"
  augroup END
endif

" Commandes automatiques }}}

" Divers {{{

" Match Octopress/Jekyll's YAML Front Matter sections
" From http://www.codeography.com/2010/02/20/making-vim-play-nice-with-jekylls-yaml-front-matter.html
let g:jekyll_path = "/home/jd/blog"
high link jekyllYamlFrontmatter Comment
execute "autocmd BufNewFile,BufRead " . g:jekyll_path . "/* syn match jekyllYamlFrontmatter /\\%^---\\_.\\{-}---$/ contains=@Spell"

" }}}

" {{{ Coloration syntaxique, couleurs, polices

" active la coloration syntaxique quand c'est possible
syntax on

function! GlobalColorSettings()
    " Set 'TODO' & 'FIXME' strings to be bold and standout as hell.
    highlight Todo term=standout ctermfg=196 ctermbg=226 guifg=#ff4500 guibg=#eeee00

    " Set cursor color to be like in jellybeans.vim colorscheme, but with black text (previously white).
    highlight Cursor ctermfg=Black ctermbg=153 guifg=#000000 guibg=#b0d0f0
endfunction
autocmd ColorScheme * call GlobalColorSettings()

" thème de coloration syntaxique par défaut
" http://vimcolorschemetest.googlecode.com/svn/html/index-c.html
colorscheme default
if $TERM == 'xterm-256color'
    "set term=xterm-256color
    "let g:solarized_termcolors=256
    "colorscheme solarized
    colorscheme jellybeans
    set t_Co=256
    "set background=dark
else
    colorscheme jellybeans
endif

" solarized theme
"set background=dark
"set t_Co=256
"let g:solarized_termcolors=16
"colorscheme solarized

" jellybeans theme
"set background=light
"set t_Co=256
"colorscheme oceandeep

" how many lines to sync backwards
syn sync minlines=10000 maxlines=10000

" export HTML (:TOhtml) *avec CSS*
let html_use_css = 1

" Coloration }}}

" vim: set foldmethod=marker nonumber:

