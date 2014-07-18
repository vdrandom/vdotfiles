# return if non-interactive
[[ $- != *i* ]] && return

# options
setopt APPEND_HISTORY EXTENDED_HISTORY HIST_IGNORE_DUPS EXTENDED_GLOB AUTO_CD AUTO_PUSHD PRINT_EXIT_VALUE
unsetopt BEEP NO_MATCH NOTIFY

autoload -Uz compinit zsh/terminfo
compinit
setopt MENU_COMPLETE
zstyle ':completion:*' completer _list _complete _ignored
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' rehash true
zstyle ':completion:*:kill:*:processes' command 'ps --forest -A -o pid,user,cmd'
zstyle ':completion:*:processes-names' command 'ps axho command'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# variables
[[ -n ${(M)path:#~/.local/bin} ]] || path+=($HOME/.local/bin(N))
HISTFILE="$HOME/.histfile"
HISTSIZE=1000
SAVEHIST=1000

export LS_COLORS='no=00:fi=00:di=34:ow=34;40:ln=35:pi=30;44:so=35;44:do=35;44:bd=33;44:cd=37;44:or=05;37;41:mi=05;37;41:ex=01;31:*.cmd=01;31:*.exe=01;31:*.com=01;31:*.bat=01;31:*.reg=01;31:*.app=01;31:*.txt=32:*.org=32:*.md=32:*.mkd=32:*.h=32:*.c=32:*.C=32:*.cc=32:*.cpp=32:*.cxx=32:*.objc=32:*.sh=32:*.csh=32:*.zsh=32:*.el=32:*.vim=32:*.java=32:*.pl=32:*.pm=32:*.py=32:*.rb=32:*.hs=32:*.php=32:*.htm=32:*.html=32:*.shtml=32:*.erb=32:*.haml=32:*.xml=32:*.rdf=32:*.css=32:*.sass=32:*.scss=32:*.less=32:*.js=32:*.coffee=32:*.man=32:*.0=32:*.1=32:*.2=32:*.3=32:*.4=32:*.5=32:*.6=32:*.7=32:*.8=32:*.9=32:*.l=32:*.n=32:*.p=32:*.pod=32:*.tex=32:*.bmp=33:*.cgm=33:*.dl=33:*.dvi=33:*.emf=33:*.eps=33:*.gif=33:*.jpeg=33:*.jpg=33:*.JPG=33:*.mng=33:*.pbm=33:*.pcx=33:*.pdf=33:*.pgm=33:*.png=33:*.ppm=33:*.pps=33:*.ppsx=33:*.ps=33:*.svg=33:*.svgz=33:*.tga=33:*.tif=33:*.tiff=33:*.xbm=33:*.xcf=33:*.xpm=33:*.xwd=33:*.xwd=33:*.yuv=33:*.aac=33:*.au=33:*.flac=33:*.mid=33:*.midi=33:*.mka=33:*.mp3=33:*.mpa=33:*.mpeg=33:*.mpg=33:*.ogg=33:*.ra=33:*.wav=33:*.anx=33:*.asf=33:*.avi=33:*.axv=33:*.flc=33:*.fli=33:*.flv=33:*.gl=33:*.m2v=33:*.m4v=33:*.mkv=33:*.mov=33:*.mp4=33:*.mp4v=33:*.mpeg=33:*.mpg=33:*.nuv=33:*.ogm=33:*.ogv=33:*.ogx=33:*.qt=33:*.rm=33:*.rmvb=33:*.swf=33:*.vob=33:*.wmv=33:*.doc=31:*.docx=31:*.rtf=31:*.dot=31:*.dotx=31:*.xls=31:*.xlsx=31:*.ppt=31:*.pptx=31:*.fla=31:*.psd=31:*.7z=1;35:*.apk=1;35:*.arj=1;35:*.bin=1;35:*.bz=1;35:*.bz2=1;35:*.cab=1;35:*.deb=1;35:*.dmg=1;35:*.gem=1;35:*.gz=1;35:*.iso=1;35:*.jar=1;35:*.msi=1;35:*.rar=1;35:*.rpm=1;35:*.tar=1;35:*.tbz=1;35:*.tbz2=1;35:*.tgz=1;35:*.tx=1;35:*.war=1;35:*.xpi=1;35:*.xz=1;35:*.z=1;35:*.Z=1;35:*.zip=1;35:*.ANSI-30-black=30:*.ANSI-01;30-brblack=01;30:*.ANSI-31-red=31:*.ANSI-01;31-brred=01;31:*.ANSI-32-green=32:*.ANSI-01;32-brgreen=01;32:*.ANSI-33-yellow=33:*.ANSI-01;33-bryellow=01;33:*.ANSI-34-blue=34:*.ANSI-01;34-brblue=01;34:*.ANSI-35-magenta=35:*.ANSI-01;35-brmagenta=01;35:*.ANSI-36-cyan=36:*.ANSI-01;36-brcyan=01;36:*.ANSI-37-white=37:*.ANSI-01;37-brwhite=01;37:*.log=01;32:*~=01;32:*#=01;32:*.bak=01;33:*.BAK=01;33:*.old=01;33:*.OLD=01;33:*.org_archive=01;33:*.off=01;33:*.OFF=01;33:*.dist=01;33:*.DIST=01;33:*.orig=01;33:*.ORIG=01;33:*.swp=01;33:*.swo=01;33:*,v=01;33:*.gpg=34:*.gpg=34:*.pgp=34:*.asc=34:*.3des=34:*.aes=34:*.enc=34:'
export LC_ALL='en_GB.UTF-8'
export LANG="$LC_ALL"
export PAGER='less'
export EDITOR='vim'

# ---> colors
if [[ $OSTYPE == linux-gnu ]] && [[ $TERM == screen || $TERM == xterm ]]; then
	export TERM="$TERM-256color"
fi

# ---> prompt
PROMPT="%B%(!..%(1000#..%F{red}%n%f@))%F{blue}%m%f %~ %(1j.+%F{red}%j%f.)%(!.%F{red}.%F{green})%#%f%b "

# ---> bindings
bindkey -e
# home
bindkey "^[[H" beginning-of-line # generic
bindkey "^[[1~" beginning-of-line # screen
# end
bindkey "^[[F" end-of-line # generic
bindkey "^[[4~" end-of-line # screen
# pgup / pgdown
bindkey "^[[5~" backward-word
bindkey "^[[6~" forward-word
# del
bindkey "^[[3~" delete-char
# ctrl + del
bindkey '^[[3;5~' delete-word
# ctrl + right / ctrl + left
bindkey "^[[1;5C" forward-word # generic
bindkey "^[[1;5D" backward-word # generic
# other
bindkey "^R" history-incremental-search-backward
# file rename magic
bindkey "^[m" copy-prev-shell-word

# ---> aliases:
alias vi='command vim'
alias less='command less -R'
alias cower='command cower -c'
alias pacman='command pacman --color=auto'
alias rscreen='command screen -Dr'
alias atmux='command tmux attach'
alias iconvwk='command iconv -c -f cp1251 -t koi8-r'
alias iconvuk='command iconv -c -f utf-8 -t koi8-r'
alias hist='fc -l 1'
alias beep='echo -en "\007"'
alias fixterm='echo "c"'
# grc - colorize some command outputs
if [[ -x /usr/bin/grc ]]; then
	alias ping='command grc --colour=auto ping'
	alias ping6='command grc --colour=auto ping'
	alias traceroute='command grc --colour=auto traceroute'
	alias traceroute6='command grc --colour=auto traceroute'
	alias make='command grc --colour=auto make'
	alias diff='command grc --colour=auto diff'
	alias cvs='command grc --colour=auto cvs'
	alias netstat='command grc --colour=auto netstat'
fi
# ls
if [[ $OSTYPE == freebsd* ]]; then
	alias ls='command ls -G'
elif [[ $OSTYPE == linux-gnu || $OSTYPE == cygwin ]] && [[ $HOST != *pvc* ]]; then
	alias ls='command ls --color=auto --group-directories-first '
fi
alias la='ls -FA'
alias ll='ls -lha'
alias ld='ls -lhda'
# colordiff
if [[ -x /usr/bin/colordiff || -x $HOME/.local/bin/colordiff ]]; then
	alias diff='command colordiff'
fi
# mount
alias mountiso='sudo mount -t iso9660 -o loop'
alias mountmdf='sudo mount -o loop'
alias mountnrg='sudo mount -o loop,offset=307200'
# git
alias gss='command git status -s'
alias gdf='command git diff'
alias gci='command git commit -a'
alias gup='command git pull'
# svn
alias sss='command svn status'
alias sdf='command svn diff'
alias sci='command svn commit'
alias sup='command svn up'

# ---> global aliases
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g PV='| pv |'
alias -g WCL='| wc -l'
alias -g NCL='| nc -l 17777'
alias -g TEE='>&1 >>'
# redirection
alias -g NO='1> /dev/null'
alias -g NE='2> /dev/null'
alias -g EO='2> &1'
alias -g OE='1> &2'
# iconv
alias -g UK='| iconv -f utf-8 -t koi8-r'
alias -g KU='| iconv -f koi8-r -t utf-8'

# ---> suffix aliases
text=( txt xml cfg cnf conf ini erb pp )
for i in $text[@]; do
	alias -s $i=$EDITOR
done

media=( mkv mp4 avi mpg mp3 ogg mpeg mov webm flv )
for i in $media[@]; do
	alias -s $i=mpv
done

image=( jpg png gif bmp jpeg )
for i in $image[@]; do
	alias -s $i=eog
done

# wine:
if [[ $OSTYPE != cygwin ]]; then
	alias -s exe=wine
fi

# ---> alias functions
function wine {
	if $(pwd|grep "$HOME/.wine"); then
		WINEPREFIX="$(pwd|awk -F'/' '{print "/"$2"/"$3"/"$4}')" command wine $@
	else
		command wine $@
	fi
}

# ---> other functions
function screenoffdisable {
	xset -dpms
	xset s off
}
function screenoffenable {
	xset +dpms
	xset s on
}
function zshrc {
	vim "$HOME/.zshrc"
}
autoload wine screenoffdisable screenoffenable

# command line syntax highlight from https://github.com/zsh-users/zsh-syntax-highlighting
hl_script="$HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
if [[ -r $hl_script ]]; then
	source $hl_script
	ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
fi

# history substring search à la fish from https://github.com/zsh-users/zsh-history-substring-search
hs_script="$HOME/.zsh-history-substring-search/zsh-history-substring-search.zsh"
if [[ -r $hs_script ]]; then
	source $hs_script
	bindkey "^[[A" history-substring-search-up
	bindkey "^[[B" history-substring-search-down
fi

extras=( "$HOME/.zshrc.work" )
for i in $extras[@]; do
	if [[ -r $i ]]; then
		source $i
	fi
done
