My portable vim setup
=====================

My main GUI editor is Atom for long-standing coding session, but my main TUI/console editor has been vim for years. This repository holds my portable [Neovim](https://neovim.io/) setup, which can be used to bootstrap a new machine in no time with a fully-fledged installation (including plugins, color support and tmux integration).

For the most part, that is a language-agnostic setup, but small areas are tied to the French language and my usage of a specific keyboard layout. YMMV.

Installation on a brand-new box
-------------------------------

### System dependencies

As for now, it boils down to:

* installing [ctags](http://ctags.sourceforge.net/) in its *Exuberant* flavor, which is usually available as a system package known as *exuberant-ctags* or *ctags* (with the latter, check that it actually is the Exuberant version).
* installing Node/npm


### Synopsis

I use [vim-plug](https://github.com/junegunn/vim-plug) with Neovim.

``` bash
# install Neovim first
git clone git://github.com/chikamichi/vim.git ~/.vim
mkdir -p ~/.config/nvim
ln -s ~/.vim/vimrc ~/.config/nvim/init.vim
mkdir -p ~/.local/share/nvim/backup ~/.config/nvim/spell ~/.local/share/nvim/site/autoload/ ~/.local/share/nvim/plugged
ln -s ~/.vim/spell/fr.utf-8.sug ~/.config/nvim/spell
ln -s ~/.vim/spell/fr.utf-8.spl ~/.config/nvim/spell
pip3 install neovim # For https://github.com/Shougo/deoplete.nvim
vim +PlugInstall +qall
```

Wish this could be automated:

```sh
cd ~/.local/share/nvim/plugged/tern_for_vim
npm install
```

Note: you may alternatively manually fetch the French spell dict:

```bash
wget http://ftp.vim.org/pub/vim/runtime/spell/fr.utf-8.sug
wget http://ftp.vim.org/pub/vim/runtime/spell/fr.utf-8.spl
```

256 colors support (tmux-wise)
------------------------------

*Note: All the configuration on the vim-side is included in this repository, tmux must be configured by hand though.*

I no longer use `xterm-256color` as my `TERM` value, tmux does not like it. Quoting [Tom Ryder](http://blog.sanctum.geek.nz/term-strings/):

> This is because they [tmux and screen] are “terminals within terminals”, and provide their own functionality only within the bounds of what the outer terminal can do. In addition to this, they have their own type for terminals within them; both of them use screen and its variants, such as `screen-256color`.
> 
> It’s therefore very important to check that both the outer and inner definitions for `TERM` are correct.

I am running GNU/Linux Solus with a `$TERM` of "screen-256color", which acts as the "outer terminal" and obviously provides 256 colors support (to check whether your terminal does, run `msgcat --color=test`). To gain 256color support in tmux as well, one must set the proper `TERM` in `~/.tmux.conf` and it must match the outer, hosting term. A value of `screen-256color` is therefore **required** by tmux:

``` tmux
set -g default-terminal "screen-256color"
set -g xterm-keys on
```

> It should be enough to get you up and running; may it fail, you would need to force the outer term. In your `.bashrc`, `.zshrc` or equivalent:
>
> ``` shell
> export TERM="screen-256color" # some may prefer "xterm-256color" though
> ```

The former line is to enable 256color support, while the latter one is to enable xterm-specific keycodes' forwarding, from your shell to tmux. This is required to process proper keycodes inside vim, as explained by tmux documentation:

> tmux supports passing through ctrl (and where supported by the client terminal, alt and shift) modifiers to function keys using xterm(1)-style key sequences. This may be enabled per window, or globally with the [xterm-keys] tmux command.

Unfortunately vim is not able to automatically detect those xterm keycodes, due to the `TERM` value in use (`screen-256color`). Some further configuration is thus required in `.vimrc` (all the remaining, vim-related code is *already included* in this bundle, so there is no need for you to edit anything):

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

