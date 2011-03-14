# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# ruby switch
alias ruby-switch-1.8='sudo ln -fs /usr/bin/ruby1.8                           /usr/bin/ruby &&
                       sudo ln -fs /usr/bin/irb1.8                            /usr/bin/irb  &&
                       sudo ln -fs /usr/bin/gem1.8                            /usr/bin/gem  &&
                       sudo ln -fs /var/lib/gems/1.8/gems/rake-0.8.7/bin/rake /usr/bin/rake'

alias ruby-switch-1.9='sudo ln -fs /opt/ruby1.9/bin/ruby1.9.1 /usr/bin/ruby &&
                       sudo ln -fs /opt/ruby1.9/bin/irb1.9.1  /usr/bin/irb  &&
                       sudo ln -fs /usr/local/bin/gem1.9.1    /usr/bin/gem  &&
                       sudo ln -fs /opt/ruby1.9/bin/rake      /usr/bin/rake'

