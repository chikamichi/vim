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

## 256 colors support (Ubuntu-wise)

You'll need a xterm-256colors script. Its location can be found running

``` bash
find /lib/terminfo /usr/share/terminfo -name "*256*"
```

If no script is available, you may get one installing ncurses-term (`sudo apt-get install ncurses-term`).

You may then either add the color conf in `~/.profile` (don't forget to edit the path):

``` bash
if [ -e YOUR_XTERM_256COLORS_PATH ]; then
  export TERM='xterm-256color'
else
  export TERM='xterm-color'
fi
```

or in `~/.:Xdefaults`:

```
*customization: -color
XTerm*termName:  xterm-256color
```

Then, either `source ~/.profile` or `xrdb -merge ~/.Xdefaults` to update your running shell instance.

If using the `Xdefaults` strategy, you may add this in `~/.Xsession` to automate this update:

```
if [ -f $HOME/.Xdefaults ]; then
  xrdb -merge $HOME/.Xdefaults
fi
```

Update the shell colorset:

```
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_background" --type bool false
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/use_theme_colors" --type bool false
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/palette" --type string "#070736364242:#D3D301010202:#858599990000:#B5B589890000:#26268B8BD2D2:#D3D336368282:#2A2AA1A19898:#EEEEE8E8D5D5:#00002B2B3636:#CBCB4B4B1616:#58586E6E7575:#65657B7B8383:#838394949696:#6C6C7171C4C4:#9393A1A1A1A1:#FDFDF6F6E3E3"
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/background_color" --type string "#00002B2B3636"
gconftool-2 --set "/apps/gnome-terminal/profiles/Default/foreground_color" --type string "#65657B7B8383"
```

In `.vimrc` (at the end, may complain about solarized theme not available otherwise), for instance:

```
syntax on
set background=dark
set t_Co=256
colorscheme [YourColorscheme]
```

