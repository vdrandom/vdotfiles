# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Export some useful variables
[[ -r $HOME/.local/bin && $PATH != *$HOME/.local/bin* ]] && PATH=$PATH:$HOME/.local/bin

# Some history tweaks
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000
HISTFILESIZE=2000

# Enable completion
COMP_ENABLE=true

# Other useful vars
#export LC_CTYPE= <- for system messages locale
[[ $TERM == screen || $TERM == xterm ]] && export TERM=$TERM-256color
export LC_ALL='en_GB.UTF-8'
export LANG=$LC_ALL
export PAGER='less -R'
export EDITOR='vim'
export LS_COLORS='no=00:fi=00:di=34:ow=34;40:ln=35:pi=30;44:so=35;44:do=35;44:bd=33;44:cd=37;44:or=05;37;41:mi=05;37;41:ex=01;31:*.cmd=01;31:*.exe=01;31:*.com=01;31:*.bat=01;31:*.reg=01;31:*.app=01;31:*.txt=32:*.org=32:*.md=32:*.mkd=32:*.h=32:*.c=32:*.C=32:*.cc=32:*.cpp=32:*.cxx=32:*.objc=32:*.sh=32:*.csh=32:*.zsh=32:*.el=32:*.vim=32:*.java=32:*.pl=32:*.pm=32:*.py=32:*.rb=32:*.hs=32:*.php=32:*.htm=32:*.html=32:*.shtml=32:*.erb=32:*.haml=32:*.xml=32:*.rdf=32:*.css=32:*.sass=32:*.scss=32:*.less=32:*.js=32:*.coffee=32:*.man=32:*.0=32:*.1=32:*.2=32:*.3=32:*.4=32:*.5=32:*.6=32:*.7=32:*.8=32:*.9=32:*.l=32:*.n=32:*.p=32:*.pod=32:*.tex=32:*.bmp=33:*.cgm=33:*.dl=33:*.dvi=33:*.emf=33:*.eps=33:*.gif=33:*.jpeg=33:*.jpg=33:*.JPG=33:*.mng=33:*.pbm=33:*.pcx=33:*.pdf=33:*.pgm=33:*.png=33:*.ppm=33:*.pps=33:*.ppsx=33:*.ps=33:*.svg=33:*.svgz=33:*.tga=33:*.tif=33:*.tiff=33:*.xbm=33:*.xcf=33:*.xpm=33:*.xwd=33:*.xwd=33:*.yuv=33:*.aac=33:*.au=33:*.flac=33:*.mid=33:*.midi=33:*.mka=33:*.mp3=33:*.mpa=33:*.mpeg=33:*.mpg=33:*.ogg=33:*.ra=33:*.wav=33:*.anx=33:*.asf=33:*.avi=33:*.axv=33:*.flc=33:*.fli=33:*.flv=33:*.gl=33:*.m2v=33:*.m4v=33:*.mkv=33:*.mov=33:*.mp4=33:*.mp4v=33:*.mpeg=33:*.mpg=33:*.nuv=33:*.ogm=33:*.ogv=33:*.ogx=33:*.qt=33:*.rm=33:*.rmvb=33:*.swf=33:*.vob=33:*.wmv=33:*.doc=31:*.docx=31:*.rtf=31:*.dot=31:*.dotx=31:*.xls=31:*.xlsx=31:*.ppt=31:*.pptx=31:*.fla=31:*.psd=31:*.7z=1;35:*.apk=1;35:*.arj=1;35:*.bin=1;35:*.bz=1;35:*.bz2=1;35:*.cab=1;35:*.deb=1;35:*.dmg=1;35:*.gem=1;35:*.gz=1;35:*.iso=1;35:*.jar=1;35:*.msi=1;35:*.rar=1;35:*.rpm=1;35:*.tar=1;35:*.tbz=1;35:*.tbz2=1;35:*.tgz=1;35:*.tx=1;35:*.war=1;35:*.xpi=1;35:*.xz=1;35:*.z=1;35:*.Z=1;35:*.zip=1;35:*.ANSI-30-black=30:*.ANSI-01;30-brblack=01;30:*.ANSI-31-red=31:*.ANSI-01;31-brred=01;31:*.ANSI-32-green=32:*.ANSI-01;32-brgreen=01;32:*.ANSI-33-yellow=33:*.ANSI-01;33-bryellow=01;33:*.ANSI-34-blue=34:*.ANSI-01;34-brblue=01;34:*.ANSI-35-magenta=35:*.ANSI-01;35-brmagenta=01;35:*.ANSI-36-cyan=36:*.ANSI-01;36-brcyan=01;36:*.ANSI-37-white=37:*.ANSI-01;37-brwhite=01;37:*.log=01;32:*~=01;32:*#=01;32:*.bak=01;33:*.BAK=01;33:*.old=01;33:*.OLD=01;33:*.org_archive=01;33:*.off=01;33:*.OFF=01;33:*.dist=01;33:*.DIST=01;33:*.orig=01;33:*.ORIG=01;33:*.swp=01;33:*.swo=01;33:*,v=01;33:*.gpg=34:*.gpg=34:*.pgp=34:*.asc=34:*.3des=34:*.aes=34:*.enc=34:'

# Append to history, not overwrite it
shopt -s histappend

# Check the window size after each command and, if necessary
# update the values of LINES and COLUMNS
shopt -s checkwinsize

# autocd works only with bash versions 4+.
if [[ $BASH_VERSINFO -ge 4 ]]; then
	shopt -s autocd
fi

# Color escapes description
# color escape looks like \[\e[x;3ym\]
# background escape looks like \[\e[4ym\]
# style reset escape is \[\e[0m\]
# x is style:
# 0 - regular, 1 - bold, 4 - underlined
# y is color:
# 0 - Black, 1 - Red, 2 - Green, 3 - Yellow
# 4 - Blue, 5 - Magenta, 6 - Cyan, 7 - White

if [[ $UID -eq 1000 || $UID -eq 1205 || $UID -eq 0 || $USER == 'Von Random' ]]; then
	user_ps=""
else
	user_ps="\[\e[1;31m\]\u\[\e[0m\]@"
fi
if [[ $UID -eq 0 ]]; then
	bang_ps='\[\e[1;31m\]\$\[\e[0m\]'
else
	bang_ps='\[\e[1;32m\]\$\[\e[0m\]'
fi
PS1="${user_ps}\[\e[1;34m\]\h\[\e[0m\] \[\e[1;33m\]\v\[\e[0m\] \[\e[37m\]\w\[\e[0m\] ${bang_ps} "

# bindings
#PgUp/PgDown and ctrl-arrows for skip word
bind '"[5~"':backward-word
bind '"[6~"':forward-word

# aliases
alias vi='command vim'
alias less='command less -R'
alias cower='command cower -c'
alias pacman='command pacman --color=auto'
alias rscreen='command screen -Dr'
alias atmux='command tmux attach'
alias hist='fc -l 1'
alias beep='echo -en "\007"'
alias fixterm='echo "^[c"'
# iconv:
alias iconvwk='command iconv -c -f cp1251 -t koi8-r'
alias iconvuk='command iconv -c -f utf-8 -t koi8-r'
alias iconvku='command iconv -c -f koi8-r -t utf-8'
alias iconvwu='command iconv -c -f cp1251 -t utf-8'
# grc:
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
# ls:
if [[ $OSTYPE == freebsd* ]]; then
	alias ls='command ls -G '
elif [[ $OSTYPE == linux-gnu ]] && [[ $HOSTNAME != *pvc* ]]; then
	alias ls='command ls --color=auto --group-directories-first '
fi
alias la='ls -FA'
alias ll='ls -lha'
alias ld='ls -lhda'
if [[ -x /usr/bin/colordiff || -x $HOME/.local/bin/colordiff ]]; then
	alias diff='command colordiff'
fi
# mount:
alias mountiso='sudo mount -t iso9660 -o loop'
alias mountmdf='sudo mount -o loop'
alias mountnrg='sudo mount -o loop,offset=307200'
# git:
alias gss='command git status -s'
alias gdf='command git diff'
alias gci='command git commit'
alias gup='command git pull'
# svn:
alias sss='command svn status'
alias sdf='command svn diff'
alias sci='command svn commit'
alias sup='command svn up'

# we want to see exit code on error
trap 'echo -e "\e[0mbash: exit \e[1;37m$?\e[0m"' ERR

# bash completion in case we have it
completion_path='/usr/share/bash-completion/bash_completion'
[[ COMP_ENABLE == true && -r $completion_path ]] && source $completion_path

# load additional functions and overrides
extras=( "$HOME/.bashrc.work" )
for i in ${extras[@]}; do
	if [[ -r $i ]]; then
		source $i
	fi
done
