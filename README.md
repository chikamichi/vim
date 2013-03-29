# Installation on a brand-new box

## 1. Clone the repos

``` bash
git clone git://github.com/chikamichi/vim.git ~/.vim
```

## 2. Create symlinks:

``` bash
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc
```

## 3. Switch to the `~/.vim` directory, and fetch submodules:

I manage my bundles using submodules. This is a neat feature of git and is perfectly valid and simple as long as you know what you're doing (hint: `git help submodule`). It also allows for great automation in relation with updates and removal.

``` bash
cd ~/.vim
git submodule init
git submodule update
```

## 4. Create the backup directory

``` bash
mkdir backup
```

# Locally

## Installing a plugin

``` bash
git submodule add git://vim-my-plugin bundle/my-plugin
```

I choose not to include *vim-* prefix in the directories name.

One may need to run `git submodule init` again so that further updates work smoothly against the local config. To automate this step, use the `--init` option while updating.

## Updating all plugins:

Updating submodules *binding* is as simple as running `git submodule update [--init]`.

Updating submodules *code* requires a bit more:

``` bash
git submodule foreach git checkout master
git submodule foreach git pull origin master
```

If needed, add `ignore = dirty` in `.gitignore` (see [this discussion](http://www.nils-haldenwang.de/frameworks-and-tools/git/how-to-ignore-changes-in-git-submodules)).

## Updating one plugin only

``` bash
cd ~/.vim/bundle/[the-plugin]
git pull origin master
```

## Removing a plugin

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

## 256 colors support (tmux-wise)

I no longer use xterm-256color and XDefaults hack, for tmux requirements make it more complicated than desired.

To gain 256color support in tmux, set the following in `~/.tmux.conf`:

```
set -g default-terminal "screen-256color"
set -g xterm-keys on
```

The former line is to enable 256color support, the latter one is to enable keycodes forwarding from your shell to tmux. This is required to process proper keycodes in vim, with some further configration in `.vimrc`:

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

As for the colors, here is the final configuration in `.vimrc`:

``` vi
syntax on
set background=light
set t_Co=256
set t_ut=y
colorscheme jellybeans
```

