# Installation on a brand-new box

``` bash
git clone git://github.com/chikamichi/vim.git ~/.vim

# Create symlinks:

ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc

# Switch to the `~/.vim` directory, and fetch submodules:

cd ~/.vim
git submodule init
git submodule update
```

# Locally

Install a plugin:

``` bash
git submodule add git://my.plugin bundle/my-plugin
```

Update the plugins:

``` bash
git submodule foreach git checkout master
git submodule foreach git pull origin master
```

If needed, add `ignore = dirty` in `.gitignore` (see [this discussion](http://www.nils-haldenwang.de/frameworks-and-tools/git/how-to-ignore-changes-in-git-submodules)).

Update one plugin only:

``` bash
cd ~/.vim/bundle/[the-plugin]
git pull origin master
```

Remove a plugin:

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
