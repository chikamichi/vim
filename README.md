Install a plugin:

    git submodule add git://my.plugin bundle/my-plugin

Update the plugins:

    git submodule update

Remove a plugin:

    # delete relevant lines from .gitmodules and from .git/config
    git rm --cached bundle/[the-plugin]

Push on github (chikamichi/vim):

    git hub (aka. git push origin master)
