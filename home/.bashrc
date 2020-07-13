#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -hlaF --color=auto --time-style long-iso --group-directories-first'
PS1="\[\033[1;34m\]\$(pwd)\[\033[0m\] > "

alias init-env='source ~/init_env.sh'
alias until_success='~/until_success.sh'

echo "***********************************************"
echo "* Welcome into the Yocto Building Environment *"
echo "***********************************************"
echo "This container aims to simplify the creation of embedded projects by providing"
echo "a containerized environment.To begin you should start by issuing:"
echo "init-env workspace build"
