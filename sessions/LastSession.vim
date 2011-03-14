let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
cmap <Nul> <Nop>
imap <Nul>  
cmap <F4> :bd!
imap <F4> :bd!
map! <F1> <F1>
imap <M-Down>   gkj
imap <M-Up>   gki
noremap  gggHG
nmap  :w
noremap  u
nnoremap <silent>    :silent noh|echo
nmap ,o :RT
nmap ,è :AT
nmap ,f :find
nmap ,w :w!
map ,cd :cd %:p:h
nnoremap ,, ,
vnoremap < <gv
vnoremap > >gv
nmap _e :move .-2
nmap _t :move .+1
nmap _S :%s/^\s\+//
nmap gx <Plug>NetrwBrowseX
nnoremap gf gf
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
map <F2> :A
nmap <Nul> <Nop>
vmap <Nul> <Nop>
omap <Nul> <Nop>
nnoremap <silent> <F8> :Tlist
map <F4> :bd!
omap <F1> <F1>
vmap <F1> <F1>
nnoremap <F1> :help 
map <C-Up> 
map <C-Down> 
map <M-Up> gk
map <M-Down> gj
cnoremap  gggHG
imap  :wa
inoremap  u
nmap é h
nmap å gk
nmap ó l
nmap ô gj
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set autoread
set autowrite
set background=dark
set backspace=2
set backup
set backupdir=~/.vim/backup
set cinoptions={.5s,+.5s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s
set cmdheight=2
set comments=sr://\ -,mb://\ \ ,el:///,sr:*\ -,mb:*\ \ ,el:*/,s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-
set display=lastline,uhex
set noequalalways
set expandtab
set fileencodings=ucs-bom,utf-8,default,latin1
set nofsync
set guioptions=aegirLt
set guitablabel=%!GuiTabLabel()
set guitabtooltip=%!GuiTabToolTip()
set helplang=fr
set history=2000
set hlsearch
set ignorecase
set incsearch
set isfname=@,48-57,/,.,-,_,+,,,#,$,%,~,=,:
set laststatus=2
set listchars=nbsp:·,tab:>-
set matchtime=2
set mouse=a
set printoptions=paper:a4
set ruler
set rulerformat=%40(%=%t%h%m%r%w%<\ (%n)\ %4.7l,%-7.(%c%V%)\ %P%)
set runtimepath=~/.vim,~/.vim/bundle/fugitive,/var/lib/vim/addons,/usr/share/vim/vimfiles,/usr/share/vim/vim72,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,~/.vim/after
set scrolloff=3
set shiftround
set shiftwidth=2
set shortmess=aotTWI
set showcmd
set showmatch
set showtabline=2
set sidescroll=5
set sidescrolloff=3
set smartcase
set softtabstop=2
set splitbelow
set nostartofline
set suffixes=.h,.bak,~,.o,.info,.swp,.obj
set timeoutlen=3000
set ttimeoutlen=100
set updatecount=0
set wildignore=*.o,*.r,*.so,*.sl,*.tar,*.tgz,*.pyc,*~
set wildmenu
set wildmode=list:longest,list:full
set winaltkeys=no
set winminheight=0
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/.vim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +0 .git/objects/08/923d0367621d2ae742119c1a9e56aee9dade07
silent! argdel *
edit .git/objects/08/923d0367621d2ae742119c1a9e56aee9dade07
set splitbelow splitright
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
cnoremap <buffer> <expr>  fugitive#buffer().rev()
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions={.5s,+.5s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s
setlocal cinwords=if,else,while,do,for,switch
setlocal comments=sr://\ -,mb://\ \ ,el:///,sr:*\ -,mb:*\ \ ,el:*/,s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-
setlocal commentstring=/*%s*/
setlocal complete=.,w,b,u,t,i
setlocal completefunc=
setlocal nocopyindent
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != ''
setlocal filetype=
endif
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=marker
setlocal foldmethod=marker
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=tcq
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=2
setlocal imsearch=2
setlocal include=
setlocal includeexpr=
setlocal indentexpr=
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
set linebreak
setlocal linebreak
setlocal nolisp
set list
setlocal list
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=2
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != ''
setlocal syntax=
endif
setlocal tabstop=8
setlocal tags=./tags,./TAGS,tags,TAGS,~/.vim/.git/tags
setlocal textwidth=0
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
let s:l = 1 - ((0 * winheight(0) + 18) / 37)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
lcd ~/.vim
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=aotTWI
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
