" jd AT vauguet DOT fr
" available at http://github.com/chikamichi/config-files/

" {{{ Génériques

" no compatibility
set nocp

" reload the buffer if edited -- never played well for me
"autocmd! BufWritePost .vimrc source ~/.vimrc

" automatically read in external changes if we haven't modified the buffer
set autoread

" automatically flush to disk when using :make, etc.
set autowrite

" if you :q with changes it asks you if you want to continue or not
" drived me mad with vim-taglist on
"set confirm

" default encoding
set encoding=utf-8
set fileencoding=utf-8

" auto +x
"au BufWritePost *.{sh,pl} silent exe "!chmod +x %"

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
      \  if line("'\"") > 0 && line("'\"") <= line("$") |
      \    exe "normal g`\"" |
      \  endif

" create non existing directories upon saving
augroup BWCCreateDir
    au!
    autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p %:h" | redraw! | endif
augroup END


" formats de fichiers pour lesquels l'autocomplétion est désactivée
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif

" add : as a file-name character (allow gf to work with http://foo.bar/)
set isfname+=:

" accélère le rendu graphique dans les terminaux véloces
set ttyfast

" faster!
set timeout timeoutlen=3000 ttimeoutlen=100

" le système d'exploitation décide à la place de Vim le bon moment pour vider le cache
set nofsync

" hauteur de la ligne de status (utile pour les plugins de library hints,
" notifications diverses et variées type mlint, VCS…)
set ch=2

" messages plus courts de la part de Vim
set shortmess=asTI

" conserve du contexte autour du curseur d'édition
set scrolloff=3
set sidescrolloff=3

" gestion des lignes longues (:help wrap)
set wrap
set sidescroll=5
set listchars+=precedes:<,extends:>

" affiche les numéros de ligne sur le coté
set number

" met en évidence la ligne actuellement éditée
set cursorline

" place le curseur là où il était lors de la fermeture du fichier
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" la touche backspace peut supprimer tout et n'importe quoi, *dans tous les modes*
set backspace=2

" pas de compatiblité avec vi afin d'activer les fonctionnalités de Vim
set nocompatible

" pas de bip! relou lors d'une erreur
set noerrorbells

" ne PAS faire clignoter l'écran lors d'une erreur (relou^2)
set novisualbell

" active les plugins et les indentations par type de fichier
filetype on
filetype plugin indent on

" quand on tape par ex. un ")", Vim montre le "(" correspondant
set showmatch

" définitions de ce que sont les commentaires
set com& " reset to default
set com^=sr:*\ -,mb:*\ \ ,el:*/ com^=sr://\ -,mb://\ \ ,el:///

" ajoute une marge à gauche pour afficher les +/- des replis (folds)
if has("gui_running")
  set foldcolumn=2
endif

" autorise le folding
set foldenable

" critère par défaut pour replier les blocs : marqueurs explicites {{{ … }}}
set foldmethod=marker

" se placer automatiquement dans le dossier du fichier actuellement édité
" désactivé pour conserver la fonctionnalité d'OmniCompletion
"autocmd BufEnter * lcd %:p:h

" mouse support in terminals
if !has("gui_running")
  set mouse=a
endif

" don't move the cursor to the start of the line when changing buffers
set nostartofline

" hide the mouse in the gui while typing
set mousehide

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

" Génériques }}}

" {{{ Indentation
" à lire avant toute copier/coller stupide : http://vim.wikia.com/wiki/Indenting_source_code
" compte tenu du 'filetype plugin indent on' précédent, pas de smartindent !

" indentation automatique en l'absence de réglages pour le filetype courant
set autoindent

" des espaces à la place du caractère TAB
set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab

" < and > will hit indentation levels instead of always -4/+4
set shiftround

" some nice options for cindenting, by FOLKE
set cinoptions={.5s,+.5s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s

" keep the current selection when indenting (thanks cbus)
vnoremap < <gv
vnoremap > >gv

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

" regexp version magic
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

" !!! use 'g'-flag when substituting (subst. all matches in that line, not only first)
" to turn off, use g (why is there no -g ?)
" set gdefault

" <espace> deux fois en mode normal efface les messages et les résultats de recherche
nnoremap <silent> <Space><Space> :silent noh<Bar>echo<CR>

" expliciter les espaces insécables
set listchars=nbsp:·,tab:>-
set list

" Recherche et subsitution }}}

" {{{ Coloration syntaxique, couleurs, polices

" active la coloration syntaxique quand c'est possible
"if &t_Co > 2 || has("gui_running")
syntax on
"endif

" thème de coloration syntaxique par défaut
" http://vimcolorschemetest.googlecode.com/svn/html/index-c.html
colorscheme default
if $COLORTERM == 'rxvt-256color'
    "set term=rxvt-256color
    colorscheme jellybeans
else
    colorscheme jellybeans
endif

if has("gui_running")
  " tente de maximiser la fenêtre GVim (problème avec Gnome et Metacity
  " non solvable par la configuration de Vim seule)
  set lines=99999 columns=99999

  " police par défaut
  if has("win32")
    set guifont=Fixedsys:h9:cANSI
    "set guifont=Courier:h10:cANSI
  else
    "set guifont=Deja\ Vu\ Sans\ Mono\ 12
    " you'll need ttf-droid:
    "set guifont=Droid\ Sans\ Mono\ 14
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 16
    " réglages de l'interface
    set guioptions+=ace
    set guioptions-=mT
  endif
endif

" how many lines to sync backwards
syn sync minlines=10000 maxlines=10000

" export HTML (:TOhtml) *avec CSS*
let html_use_css = 1

" highlight long lines
"match ErrorMsg '\%>80v.\+'

" Recherche et substitution }}}

" {{{ Statusline, menu, onglets

" use tab for auto-expansion in menus
set wc=<TAB>

" show a list of all matches when tabbing a command
set wmnu

" how command line completion works
set wildmode=list:longest,list:full

" ignore some files for filename completion
set wildignore=*.o,*.r,*.so,*.sl,*.tar,*.tgz,*.pyc,*~

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

" onglets, fritzophrenic mood
" http://groups.google.com/group/vim_use/browse_thread/thread/9bbfb7f6ec651438
set showtabline=2

" highlight matching parens for .2s
set showmatch
set matchtime=2

" word wrapping -- don't cut words
set linebreak

" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)

  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label = '+'
      break
    endif
  endfor

  " Append the tab number
  let label .= tabpagenr().': '

  " Append the buffer name
  let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
  if name == ''
    " give a name to no-name documents
    if &buftype=='quickfix'
      let name = '[Quickfix List]'
    else
      let name = '[Non enregistré]'
    endif
  else
    " get only the file name
    let name = fnamemodify(name,":t")
  endif
  let label .= name

  " Append the number of windows in the tab page
  let wincount = tabpagewinnr(v:lnum, '$')
  return label . '  [' . wincount . ']'
endfunction

" set up tab tooltips with every buffer name
function! GuiTabToolTip()
  let tip = ''
  let bufnrlist = tabpagebuflist(v:lnum)

  for bufnr in bufnrlist
    " separate buffer entries
    if tip!=''
      let tip .= ' | '
    endif

    " Add name of buffer
    let name=bufname(bufnr)
    if name == ''
      " give a name to no name documents
      if getbufvar(bufnr,'&buftype')=='quickfix'
        let name = '[Quickfix List]'
      else
        let name = '[Non enregistré]'
      endif
    endif
    let tip.=name

    " add modified/modifiable flags
    if getbufvar(bufnr, "&modified")
      let tip .= ' [+]'
    endif
    if getbufvar(bufnr, "&modifiable")==0
      let tip .= ' [-]'
    endif
  endfor

  return tip
endfunction

set guitablabel=%!GuiTabLabel()
set guitabtooltip=%!GuiTabToolTip()

" Statusline, menu, onglets }}}

" {{{ Gestion du fenêtrage

" tabs everywhere!
" you'll need to edit gvim.desktop:
" http://vim.wikia.com/wiki/Launch_files_in_new_tabs_under_Unix 
tab all

if has("gui_running")
  " le focus suit la souris
  set mousef
  " le bouton droit affiche une popup
  set mousemodel=popup_setpos
endif

"Toggle Menu and Toolbar
set guioptions-=m
set guioptions-=T
"map <silent> <F2> :if &guioptions =~# 'T' <Bar>
      "\set guioptions-=T <Bar>
      "\set guioptions-=m <bar>
      "\else <Bar>
      "\set guioptions+=T <Bar>
      "\set guioptions+=m <Bar>
      "\endif<CR>

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

" activation de la sauvagarde
set backup

" répertoire de sauvegarde automatique
set backupdir=~/.vim/backup

" le swap est mis à jour aprés 50 caractères saisies
"set updatecount=500
" suppression de l'utilisation du fichier d'échange
set updatecount=0

" force save with "W" using sudo
command W w !sudo tee % > /dev/null

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

" raccourci classique pour sauvegarder
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a
nmap <leader>w :w!<CR>

" collage propre depuis le buffer extérieur (indentations)
" pas besoin pour ma part, à l'usage
"inoremap <C-v> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>

" raccourci pratique pour rechercher
nmap <leader>f :find<CR>

" supprime tout les blancs en debut de ligne
nmap _S :%s/^\s\+//<CR>

" déplace la ligne courante vers le bas
nmap _t :move .+1<CR>
" déplace la ligne courante vers le haut
nmap _e :move .-2<CR>

" converts file format to/from unix
command! Unixformat :set ff=unix
command! Dosformat  :set ff=dos

" raccourcis classiques pour annuler
inoremap <C-Z> <C-O>u
noremap  <C-Z> u

" raccourcis classiques pour refaire
" (supprimé car en confit avec le scroll montant)
"noremap <C-Y> <C-R>
"inoremap <C-Y> <C-O><C-R>

" scroll vers le bas sans bouger le curseur
map <C-DOWN> <C-E>
" scroll vers le haut sans bouger le curseur
map <C-UP> <C-Y>

" tout séléctionner
noremap <C-A> gggH<C-O>G
"inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G

" indentation automatique (à la Emacs)
" je ne suis plus vraiment certain que ça me soit utile…
"vnoremap <C-F>   =$
"vnoremap <tab>   =
"nnoremap <tab>   =$
"nnoremap <C-tab> mzvip=`z

" <F1> lance la commande d'aide au lieu d'afficher l'intro de l'aide
nnoremap <F1> :help<Space>
vmap <F1> <C-C><F1>
omap <F1> <C-C><F1>
map! <F1> <C-C><F1>

" indent XML inline files
"au FileType xml exe ":silent 1,$!tidy --input-xml yes --indent auto --utf8 2>/dev/null"
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

" forcer la fermeture d'un tampon
map  <F4> :bd!<cr>
imap <F4> <C-O>:bd!<cr>
cmap <F4> <c-c>:bd!<cr>

" active/désactive la navigation par tags
nnoremap <silent> <F8> :Tlist<CR>

if has("gui_running")
  " Maj-[flèche] pour sélectionner un bloc
  map  <S-Up>    vk
  vmap <S-Up>    k
  map  <S-Down>  vj
  vmap <S-Down>  j
  map  <S-Right> v
  vmap <S-Right> l
  map  <S-Left>  v
  vmap <S-Left>  h
endif

" gestion du caractère NULL dans tous les modes
imap <Nul> <Space>
map  <Nul> <Nop>
vmap <Nul> <Nop>
cmap <Nul> <Nop>
nmap <Nul> <Nop>

" switch between header/code files
map <F2> :A<CR>

" Rails.vim jumpers
" opens the alternate file in a new tab
nmap <leader>è :AT<CR>
" opens the related file in a new tab
nmap <leader>o :RT<CR>

" Open related file in a new tab by default
nnoremap gf <C-W>gf

" Mappings }}}

" {{{ Plugins

" interesting ones but not tested yet:
" - coding styles per project: http://www.vim.org/scripts/script.php?script_id=2633

call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" {{{ Commandes automatiques

if has("autocmd")
  augroup augroup_autocmd
    au!
    filetype plugin on

    " se placer à la position du curseur lors de la fermeture du fichier
    autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif

    " par type de fichier
    autocmd FileType text        setlocal textwidth=78 nocindent
    autocmd FileType html        set      formatoptions+=tl

    " plugin autoclosetag
    au FileType xhtml,xml so ~/.vim/ftplugin/html_autoclosetag.vim
    autocmd FileType c,cpp,slang set      cindent

    " par extension, pour les cas tricky
    autocmd BufNewFile,BufRead *.pc           set filetype proc
    autocmd BufNewFile,BufRead *.phtm,*.phtml set filetype php
    autocmd BufNewFile,BufRead *.asy          set filetype asy
    autocmd BufNewFile,BufRead *.rhtml,*.erb  set filetype eruby
    autocmd BufNewFile,BufRead *.haml         set filetype haml 
    autocmd BufNewFile,BufRead *.sass,*.scss  set filetype sass 
    autocmd BufNewFile,BufRead *.less         set filetype less
    autocmd BufNewFile,BufRead *.md           set filetype markdown
    autocmd BufNewFile,BufRead *.mustache     set filetype mustache
    autocmd BufNewFile,BufRead /etc/nginx/sites-available/* set ft=nginx 

    " tabulation stricte dans les Makefile
    autocmd FileType make     set noexpandtab
  augroup END
endif

" always cd to the current file/buffer directory
"if exists('+autochdir')
"set autochdir
"else
"autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
"endif

" Commandes automatiques }}}

" Ack
" https://github.com/mileszs/ack.vim
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" Plugins }}}

" vim: set foldmethod=marker nonumber:

