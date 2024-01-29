# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
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

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
alias ll="ls -lart --time-style=long-iso"

showhist() {
    [ -z "$1" ] && { printf "usage:  hist <search term>\n"; return 1; }
    history | grep "$1"
    return 0
}
alias h='showhist'

findsource() {
  [ -z "$1" ] && { printf "findsource: search for *.c,*.cpp,*.h containing pattern\n  usage:  findsource <search string>\n"; return 1; }
  # echo Pattern="$1" pwd=$(pwd)
  grep --include=\*.{c,cpp,h} -rnw . -e "$1" | awk -F":" {'printf "%40s %5s : %s\n", $1,$2,$3'}
  return 0
}  
alias fs='findsource'

function print_tree_info {
  dmesg | grep altera
  echo ""
  find -L /proc/device-tree -name "*fpga*"
  echo ""
  sudo grep soc /proc/iomem
}

## print_tree_info
cd ~/mic-server/
echo ""
git status
if [ -f ~/.restart_exec ]; then
  echo ""
  echo "********  Script execution scheduled prior restart - going for it!"
  echo "********  Invoking only ONCE - removing symlink"
  cd ~
  # unlink .restart_exec <-- this was "cutting the branch we are sitting on"!
  ~/.restart_exec
  echo "********  Done with scheduled script execution"
  unlink ~/.restart_exec
fi
alias nc="/home/debian/mic-server/script/nc.sh"
