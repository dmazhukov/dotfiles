echo "Loading .zshrc"
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'

### Added by Zplugin's installer
source $HOME/.zplugin/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

export TERM='xterm-256color'
source $HOME/.zsh-tools/zaw/zaw.zsh

# Load OMZ Git library
zplugin snippet OMZ::lib/git.zsh
zplugin snippet OMZ::lib/completion.zsh
zplugin snippet OMZ::lib/compfix.zsh

# Load Git plugin from OMZ
zplugin ice wait'0' atload"unalias grv" lucid
zplugin snippet OMZ::plugins/git/git.plugin.zsh
zplugin snippet PZT::modules/helper/init.zsh
zplugin cdclear -q # <- forget completions provided up to this moment

#setopt promptsubst
COMPLETION_WAITING_DOTS="true"
setopt EXTENDED_GLOB
# Ignore <C-d> logout
setopt IGNORE_EOF
# Disable beeps
setopt NO_BEEP
# {a-c} -> a b c
setopt BRACE_CCL
# History ignoreb dups
setopt HIST_IGNORE_DUPS
# History reduce spaces
setopt HIST_REDUCE_BLANKS
# History ignore if there is a space
setopt HIST_IGNORE_SPACE
# History save time stamp
setopt EXTENDED_HISTORY
# Expand history
setopt HIST_EXPAND
# Better jobs
setopt LONG_LIST_JOBS
# Add "/" if completes directory
setopt MARK_DIRS
# Print exit value if return code is non-zero
# setopt print_exit_value
# Enable comment string
setopt INTERACTIVE_COMMENTS
# List completion
#setopt AUTO_LIST
# setopt MENU_COMPLETE
# Check original command in alias completion
# setopt COMPLETE_ALIASES
# silent no match
unsetopt NOMATCH

setopt FLOW_SHELL

# menu completion
# zstyle ':completion:*' menu select

# enable colors {{{
export CLICOLOR=1
if [ "${ZSH_UNAME}" = "Darwin" ]; then
      # export LSCOLORS="exfxcxdxbxegedabagacad"
#     export LSCOLORS="ExGxFxDxCxDxDxhbhdacEc"
#     LS_COLORS="${LSCOLORS}"
    export LS_COLORS="di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32"
    LS_COLORS="${LSCOLORS}"

else
    export LS_COLORS="di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32"
fi
zstyle ':completion:*:default' list-colors ${LS_COLORS}
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# }}}

# Share zsh histories {{{
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=50000
setopt inc_append_history
setopt share_history
# }}}
#############################################
#               Aliases
#############################################
#
# source zshrc
alias sz='source ~/.zshrc'

# General {{{
# I hate the 'whence' function
command which which>/dev/null 2>&1 && {
    alias which="$(command which which)"
}
alias f='fzf -e'
#############################################

bindkey "^[OB" down-line-or-search
bindkey "^[OC" forward-char
bindkey "^[OD" backward-char
bindkey "^[OF" end-of-line
bindkey "^[OH" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[3~" delete-char
bindkey "^[[4~" end-of-line
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey "^?" backward-delete-char
# alt + left/right: jump one word backward/forward
bindkey '^[^[[D' emacs-backward-word
bindkey '^[^[[C' emacs-forward-word


setopt MAGIC_EQUAL_SUBST
setopt BSD_ECHO

extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2) tar xvjf $1   ;;
      *.tar.gz)  tar xvzf $1   ;;
      *.tar.xz)  tar xvfJ $1   ;;
      *.bz2)     bunzip2 $1    ;;
      *.rar)     unrar x $1    ;;
      *.gz)      gunzip $1     ;;
      *.tar)     tar xvf $1    ;;
      *.tbz2)    tar xvjf $1   ;;
      *.tgz)     tar xvzf $1   ;;
      *.zip)     unzip $1      ;;
      *.Z)       uncompress $1 ;;
      *.7z)      7z x $1       ;;
      *)         echo "'$1' cannot be extracted via >extract<" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
bindkey '^B' push-line-or-edit
# setopt CORRECT
# unsetopt CORRECT_ALL
setopt promptsubst
###########
# Completion configuration

zstyle ':completion:*' completer _expand _complete _ignored _match _correct _describe _approximate _prefix _gnu-generic #_prefix _describe _gnu-generic
#zstyle ':completion:*' completer _describe
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
# zstyle ':completion:*' insert-unambiguous false
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '+' '+m:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+r:|[._-]=* r:|=*' '+l:|=* r:|=*'
zstyle ':completion:*' match-original only
zstyle ':completion:*' max-errors 6 numeric
# zstyle ':completion:*' menu select=1
zstyle ':completion:*' original true
# zstyle ':completion:*' verbose true

zstyle ':completion:*' gain-privileges 
zstyle ':completion:*' group-name ''
zstyle ':completion:*' auto-description



setopt hash_list_all            # hash everything before completion
# setopt completealiases          # complete alisases
setopt always_to_end            # when completing from the middle of a word, move the cursor to the end of the word    
setopt complete_in_word         # allow completion from within a word/phrase
# setopt correct                  # spelling correction for commands
setopt list_ambiguous           # complete as much of a completion until it gets ambiguous.

# zstyle ':completion::complete:*' use-cache on               # completion caching, use rehash to clear
# zstyle ':completion:*' cache-path ~/.zsh/cache              # cache path
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # ignore case
# zstyle ':completion:*' menu select=2                        # menu if nb items > 2
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}       # colorz !
# zstyle ':completion:*::::' completer _expand _complete _ignored _approximate # list of completers to use

# # sections completion !
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format $'\e[00;34m%d'
zstyle ':completion:*:messages' format $'\e[00;31m%d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true

zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=29=34"
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always
users=(dmitry root)           # because I don't care about others
zstyle ':completion:*' users $users

##
# Pushd
##
setopt auto_pushd               # make cd push old dir in dir stack
setopt pushd_ignore_dups        # no duplicates in dir stack
setopt pushd_silent             # no dir stack after pushd or popd
setopt pushd_to_home            # `pushd` = `pushd $HOME`

#######################################################

###
#zplg ice svn silent wait'!0' atload'prompt smiley'
#zplg snippet PZT::modules/prompt
###
zplugin ice wait'1' atload'_zsh_autosuggest_start'
zplugin light zsh-users/zsh-autosuggestions
###

###GIT EXTRAS START###
zplugin ice wait"2" lucid as"program" pick"bin/git-dsf"
zplugin light zdharma/zsh-diff-so-fancy
zplugin ice wait"2" lucid as"program" pick"$ZPFX/bin/git-now" make"prefix=$ZPFX install"
zplugin light iwata/git-now
zplugin ice wait"2" lucid as"program" pick"$ZPFX/bin/git-alias" make"PREFIX=$ZPFX"
zplugin light tj/git-extras
zplugin ice wait"2" lucid as"program" atclone'perl Makefile.PL PREFIX=$ZPFX' atpull'%atclone' \
            make'install' pick"$ZPFX/bin/git-cal"
zplugin light k4rthik/git-cal

###GIT EXTRAS END###

# D.
zplugin ice wait'2' lucid
zplugin snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/history
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/z
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/brew
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/common-aliases
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/colored-man-pages
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/transfer
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/ubuntu
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/systemd
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/debian
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/systemadmin
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/colorize
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/command-not-found
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/sudo
# zplugin ice wait'2' lucid svn
# zplugin snippet OMZ::plugins/themes
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/pip
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/python
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/pyenv
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/virtualenv
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/dotenv
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/docker-compose
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/docker-machine
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/nmap
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/postgres
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/compleat
# zplugin ice wait'2' lucid svn
# zplugin snippet OMZ::plugins/aws
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/battery
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/fancy-ctrl-z
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/terraform
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/minikube
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/kubectl
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/man
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/go
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/gitignore

zplugin ice svn wait"0" lucid atinit"local ZSH=\$PWD" \
    atclone"mkdir -p plugins; cd plugins; ln -sfn ../. osx"
zplugin ice wait'2' lucid svn
zplugin snippet OMZ::plugins/osx

# Load theme from OMZ
# zplugin snippet OMZ::themes/dstufft.zsh-theme
# E.
zplugin wait'0' lucid
zplugin light danihodovic/steeef

# Load normal Github plugin with theme depending on OMZ Git library
# zplugin light NicoSantangelo/Alpharized


# F.

zplugin load zdharma/history-search-multi-word

zplugin ice compile"*.lzui"
zplugin load zdharma/zui
zplugin light zdharma/zplugin-crasis

# Binary release in archive, from Github-releases page; after automatic unpacking it provides command "fzf"

zplugin ice from"gh-r" as"program"; zplugin load junegunn/fzf-bin

# One other binary release, it needs renaming from `docker-compose-Linux-x86_64`.
# Used also `bpick' which selects Linux packages – in this case not needed, Zplugin
#automatically narrows down the releases by grepping uname etc.

zplugin ice from"gh-r" bpick"*linux*" as"program" mv"docker* -> docker-compose"; zplugin load docker/compose

zplugin ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zplugin light tj/git-extras

zplugin ice pick"h.sh"
zplugin light paoloantinori/hhighlighter

zplugin ice wait"0" blockf
zplugin light djui/alias-tips

zplugin ice wait"0" blockf
zplugin light zsh-users/zsh-completions

zplugin ice wait'1' atload'_zsh_autosuggest_start'
zplugin light zsh-users/zsh-autosuggestions

zplugin ice wait'1' atinit"zpcompinit; zpcdreplay"
zplugin light zdharma/fast-syntax-highlighting

##########ZPLUGIN END########################

zstyle ':completion:*:*:mpv:*' group-name ''
