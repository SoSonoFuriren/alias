# Environment Configuration
# PATH, library paths, and other environment variables

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PKG_CONFIG_PATH=${PKG_CONFIG_PATH}:/usr/local/lib64/pkgconfig
export PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig:/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
export LD_LIBRARY_PATH=/usr/local/lib64:/usr/local/lib:$LD_LIBRARY_PATH
# export MANPATH="/usr/local/man:$MANPATH"
# export LANG=en_US.UTF-8
#   export EDITOR='vim'
#   export EDITOR='nvim'
# export ARCHFLAGS="-arch $(uname -m)"
