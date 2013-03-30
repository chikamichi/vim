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

### 3. Fetch the plugins

I manage my bundles using [submodules](http://git-scm.com/book/en/Git-Tools-Submodules). You may have heard bad things about either submodules themselves or using them alongside Pathogen. Don't be afraid: submodules is a great feature of git and levaraging them here is perfectly valid and simple, as long as you know what you're doing (hint: `git help submodule` or click on the former link). It allows for an efficient automation (note to self: *planning to wrap it up with a Thor script to reduce typing*).

``` bash
cd ~/.vim
git submodule init
git submodule update
```

### 4. Create the required backup directory

``` bash
mkdir backup
```

Local managment
---------------

### Installing a plugin

``` bash
git submodule add git://vim-my-plugin bundle/my-plugin
```

I choose not to include *vim-* prefix in the directories name.

One may need to run `git submodule init` again so that further updates work smoothly against the local config. To automate this step, use the `--init` option while updating.

### Updating all plugins

Updating submodules *binding* is as simple as running `git submodule update [--init]`.

Updating submodules *code* requires a bit more:

``` bash
git submodule foreach git checkout master
git submodule foreach git pull origin master
```

If needed, add `ignore = dirty` in `.gitignore` (see [this discussion](http://www.nils-haldenwang.de/frameworks-and-tools/git/how-to-ignore-changes-in-git-submodules)).

### Updating one plugin only

``` bash
cd ~/.vim/bundle/[the-plugin]
git pull origin master
```

### Removing a plugin

``` bash
# delete relevant lines from .gitmodules and from .git/config
git rm --cached bundle/[the-plugin] # without the trailing slash
```

Push on github (chikamichi/vim):

``` bash
git commit -a -m "submodules update"
git hub # (my alias for git push origin master)
```

See [vim-scripts](https://github.com/vim-scripts/) on github.

256 colors support (tmux-wise)
------------------------------

*Note: All the configuration on the vim-side is included in this repository, tmux must be configured by hand though.*

I no longer use xterm-256color as my `TERM` value, tmux does not like it. Quoting [Tom Ryder](http://blog.sanctum.geek.nz/term-strings/):

> This is because they are “terminals within terminals”, and provide their own functionality only within the bounds of what the outer terminal can do. In addition to this, they have their own type for terminals within them; both of them use screen and its variants, such as `screen-256color`.
> 
> It’s therefore very important to check that both the outer and inner definitions for `TERM` are correct.

Running Ubuntu, its default xterm comes with 256color support (to check whether yours has, run `msgcat --color=test`). To gain 256color support in tmux as well, set the proper `TERM` value in `~/.tmux.conf`:

```
set -g default-terminal "screen-256color"
set -g xterm-keys on
```

The former line is to enable 256color support, the latter one is to enable xterm-specific keycodes forwarding from your shell to tmux. This is required to process proper keycodes in vim, as described in tmux documentation:

> tmux supports passing through ctrl (and where supported by the client terminal, alt and shift) modifiers to function keys using xterm(1)-style key sequences. This may be enabled per window, or globally with the [xterm-keys] tmux command.

But vim is not able to automatically detect those xterm keycodes, due to the `TERM` value in use (`screen-256color`). Some further configuration is thus required in `.vimrc`. The following is already included in this bundle, so there is no need for you to edit anything.

``` vi
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

``` vi
" Go to the previous tab.
map <M-Left> gT
" Go to the next tab.
map <M-Right> gt
```

As for the colors and term integration, here is the final configuration in `.vimrc`:

``` vi
syntax on
set mouse=a
set ttymouse=xterm
set ttyfast
set background=light
set t_Co=256
set t_ut=y
colorscheme jellybeans
```

Note that the `t_Co` setting is to `force` vim to trust the term it runs within has 256color support, even though it may not be detected.

More (rock-solid) info on `TERM` management on the [Arabesque blog](http://blog.sanctum.geek.nz/term-strings/).

