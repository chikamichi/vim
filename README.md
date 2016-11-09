My portable vim setup
=====================

Altough I may use Sublime Text 3, gEdit or Libre Office Writer from time to time depending on the document to be edited, my main editor is vim *in console*, inside [tmux](http://tmux.sourceforge.net/). This repository holds my portable vim setup which can be used to bootstrap a new machine in no time with a fully-fledged installation (with plugins, color support and tmux integration all included).

Installation on a brand-new box
-------------------------------

### 1. Clone this repository

``` bash
git clone git://github.com/chikamichi/vim.git ~/.vim
```

### 2. Create required symlinks

``` bash
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc
```

### 3. Create the required backup directory

``` bash
mkdir ~/.vim/backup
```

### 4. Install system dependencies

As for now, it boils down to installing [ctags](http://ctags.sourceforge.net/) in its *Exuberant* flavor.

ctags can be installed with `sudo apt-get install exuberant-ctags`.

### 5. Fetch the plugins

I use [Vundle](https://github.com/gmarik/vundle). Install it, then:

``` bash
vim +PluginInstall +qall
```

256 colors support (tmux-wise)
------------------------------

*Note: All the configuration on the vim-side is included in this repository, tmux must be configured by hand though.*

I no longer use `xterm-256color` as my `TERM` value, tmux does not like it. Quoting [Tom Ryder](http://blog.sanctum.geek.nz/term-strings/):

> This is because they [tmux and screen] are “terminals within terminals”, and provide their own functionality only within the bounds of what the outer terminal can do. In addition to this, they have their own type for terminals within them; both of them use screen and its variants, such as `screen-256color`.
> 
> It’s therefore very important to check that both the outer and inner definitions for `TERM` are correct.

Running Ubuntu, its default xterm, acting as the "outer terminal", is handy enough to come with 256color support built-in (to check whether your terminal does, run `msgcat --color=test`). To gain 256color support in tmux as well, you must set the proper `TERM` in `~/.tmux.conf`. A value of `screen-256color` is **required** by tmux:

``` tmux
set -g default-terminal "screen-256color"
set -g xterm-keys on
```

If it fails, you may need to force the outer term. In your `.bashrc`:

``` shell
export TERM="xterm-256color"
```

The former line is to enable 256color support, while the latter one is to enable xterm-specific keycodes' forwarding, from your shell to tmux. This is required to process proper keycodes inside vim, as explained by tmux documentation:

> tmux supports passing through ctrl (and where supported by the client terminal, alt and shift) modifiers to function keys using xterm(1)-style key sequences. This may be enabled per window, or globally with the [xterm-keys] tmux command.

But vim is not able to automatically detect those xterm keycodes, due to the `TERM` value in use (`screen-256color`). Some further configuration is thus required in `.vimrc` (all the remaining, vim-related code is *already included* in this bundle, so there is no need for you to edit anything):

``` viml
" Make Vim recognize xterm escape sequences for Page and Arrow
" keys, combined with any modifiers such as Shift, Control, and Alt.
" See http://unix.stackexchange.com/questions/29907/how-to-get-vim-to-work-with-tmux-properly
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
```

One can now map directions with modifiers. For instance, you may want Alt+Left/Right to navigate through your opened tabs (Alt is Meta under Ubuntu):

``` viml
" Go to the previous tab.
map <M-Left> gT
" Go to the next tab.
map <M-Right> gt
```

As for the colors and term integration, here is the final configuration in `.vimrc`:

``` viml
syntax on
set mouse=a
set ttymouse=xterm
set ttyfast
set background=light
set t_Co=256
set t_ut=
colorscheme jellybeans
```

Note that the `t_Co` setting is to *force* vim to trust the term it runs within has 256color support, even though it may not be detected.

More (rock-solid) info on `TERM` management on the [Arabesque blog](http://blog.sanctum.geek.nz/term-strings/).

