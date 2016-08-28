# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# {{{ settings
vscripts="${HOME}/vscripts"
local_bin="${HOME}/.local/bin"
gem_bin="${HOME}/.local/gem-bin"
[[ -d ${vscripts} && ${PATH} != *${vscripts}* ]] && export PATH=${PATH}:${vscripts}
[[ -d ${local_bin} && ${PATH} != *${local_bin}* ]] && export PATH=${PATH}:${local_bin}
[[ -h ${gem_bin} && ${PATH} != *${gem_bin}* ]] && export PATH=${PATH}:${gem_bin}
unset local_bin vscripts gem_bin

dotfiles="${HOME}/vdotfiles"
#comp_enabled=true
#git_enabled=true

HISTSIZE=1000
HISTFILE="${HOME}/.bash_history.${UID}"
HISTCONTROL=ignoredups:ignorespace
shopt -s histappend checkwinsize
[[ ${BASH_VERSINFO} -ge 4 ]] && shopt -s autocd

export MYSQL_PS1="mysql [\d]> "
export SSH_AUTH_SOCK="${HOME}/.ssh/ssh_auth_sock"
export TIME_STYLE='long-iso'

export LANG='en_US.utf8'
export LANGUAGE="$LANG"
export EDITOR='vim'
export PAGER='less -R'
export LS_COLORS='no=00:fi=00:di=34:ow=34;40:ln=35:pi=30;44:so=35;44:do=35;44:bd=33;44:cd=37;44:or=05;37;41:mi=05;37;41:ex=01;31:*.cmd=01;31:*.exe=01;31:*.com=01;31:*.bat=01;31:*.reg=01;31:*.app=01;31:*.txt=32:*.org=32:*.md=32:*.mkd=32:*.h=32:*.c=32:*.C=32:*.cc=32:*.cpp=32:*.cxx=32:*.objc=32:*.sh=32:*.csh=32:*.zsh=32:*.el=32:*.vim=32:*.java=32:*.pl=32:*.pm=32:*.py=32:*.rb=32:*.hs=32:*.php=32:*.htm=32:*.html=32:*.shtml=32:*.erb=32:*.haml=32:*.xml=32:*.rdf=32:*.css=32:*.sass=32:*.scss=32:*.less=32:*.js=32:*.coffee=32:*.man=32:*.0=32:*.1=32:*.2=32:*.3=32:*.4=32:*.5=32:*.6=32:*.7=32:*.8=32:*.9=32:*.l=32:*.n=32:*.p=32:*.pod=32:*.tex=32:*.bmp=33:*.cgm=33:*.dl=33:*.dvi=33:*.emf=33:*.eps=33:*.gif=33:*.jpeg=33:*.jpg=33:*.JPG=33:*.mng=33:*.pbm=33:*.pcx=33:*.pdf=33:*.pgm=33:*.png=33:*.ppm=33:*.pps=33:*.ppsx=33:*.ps=33:*.svg=33:*.svgz=33:*.tga=33:*.tif=33:*.tiff=33:*.xbm=33:*.xcf=33:*.xpm=33:*.xwd=33:*.xwd=33:*.yuv=33:*.aac=33:*.au=33:*.flac=33:*.mid=33:*.midi=33:*.mka=33:*.mp3=33:*.mpa=33:*.mpeg=33:*.mpg=33:*.ogg=33:*.ra=33:*.wav=33:*.anx=33:*.asf=33:*.avi=33:*.axv=33:*.flc=33:*.fli=33:*.flv=33:*.gl=33:*.m2v=33:*.m4v=33:*.mkv=33:*.mov=33:*.mp4=33:*.mp4v=33:*.mpeg=33:*.mpg=33:*.nuv=33:*.ogm=33:*.ogv=33:*.ogx=33:*.qt=33:*.rm=33:*.rmvb=33:*.swf=33:*.vob=33:*.wmv=33:*.doc=31:*.docx=31:*.rtf=31:*.dot=31:*.dotx=31:*.xls=31:*.xlsx=31:*.ppt=31:*.pptx=31:*.fla=31:*.psd=31:*.7z=1;35:*.apk=1;35:*.arj=1;35:*.bin=1;35:*.bz=1;35:*.bz2=1;35:*.cab=1;35:*.deb=1;35:*.dmg=1;35:*.gem=1;35:*.gz=1;35:*.iso=1;35:*.jar=1;35:*.msi=1;35:*.rar=1;35:*.rpm=1;35:*.tar=1;35:*.tbz=1;35:*.tbz2=1;35:*.tgz=1;35:*.tx=1;35:*.war=1;35:*.xpi=1;35:*.xz=1;35:*.z=1;35:*.Z=1;35:*.zip=1;35:*.ANSI-30-black=30:*.ANSI-01;30-brblack=01;30:*.ANSI-31-red=31:*.ANSI-01;31-brred=01;31:*.ANSI-32-green=32:*.ANSI-01;32-brgreen=01;32:*.ANSI-33-yellow=33:*.ANSI-01;33-bryellow=01;33:*.ANSI-34-blue=34:*.ANSI-01;34-brblue=01;34:*.ANSI-35-magenta=35:*.ANSI-01;35-brmagenta=01;35:*.ANSI-36-cyan=36:*.ANSI-01;36-brcyan=01;36:*.ANSI-37-white=37:*.ANSI-01;37-brwhite=01;37:*.log=01;32:*~=01;32:*#=01;32:*.bak=01;33:*.BAK=01;33:*.old=01;33:*.OLD=01;33:*.org_archive=01;33:*.off=01;33:*.OFF=01;33:*.dist=01;33:*.DIST=01;33:*.orig=01;33:*.ORIG=01;33:*.swp=01;33:*.swo=01;33:*,v=01;33:*.gpg=34:*.gpg=34:*.pgp=34:*.asc=34:*.3des=34:*.aes=34:*.enc=34:'

is_exec() { [[ -x $(type -P ${1}) ]]; }
# }}}
# {{{ prompt
color_number=0
for color in 'black' 'red' 'green' 'yellow' 'blue' 'magenta' 'cyan' 'white'; do
	eval "n${color}='\[\e[0;3${color_number}m\]'"
	eval "b${color}='\[\e[1;3${color_number}m\]'"
	(( color_number++ ))	
done
unset color_number
reset='\[\e[0m\]'
bold='\[\e[1m\]'
if [[ ${USER} == 'von' ]]; then
	prompt_user=""
else
	prompt_user="${nred}\u${reset} "
fi
if [[ $UID -eq 0 ]]; then
	color_bang="${nred}"
else
	color_bang="${bold}"
fi
PS1="[ ${prompt_user}${HOSTNAME}:${bold}\w${reset} ]
${color_bang}>${reset} "
# }}}
# {{{ key bindings
# urxvt
bind '"\e[7~"':beginning-of-line                      # home
bind '"\e[8~"':end-of-line                            # end
# screen
bind '"\e[1~"':beginning-of-line                      # home
bind '"\e[4~"':end-of-line                            # end
# xterm
bind '"\e[H~"':beginning-of-line                      # home
bind '"\e[F~"':end-of-line                            # end
# all of them
bind '"\e[5~"':backward-word                          # page up
bind '"\e[6~"':forward-word                           # page down
# }}}
# {{{ aliases
alias whence='type -P'
alias less='command less -R'
alias cower='command cower -c'
alias pacman='command pacman --color=auto'
alias rscreen='command screen -Dr'
alias rdesktop='command rdesktop -g1580x860'
alias rgrep='command grep --exclude-dir=\.git -R'
alias hist='fc -l 1'
alias beep='printf "\007"'
alias fixterm='printf "c"'
alias vi='command vim'
alias pg-linux-client='command sudo -u postgres psql'
alias mysql='mysql --sigint-ignore'

# iconv
alias iconvwk='command iconv -c -f cp1251 -t koi8-r'
alias iconvuk='command iconv -c -f utf-8 -t koi8-r'
alias iconvku='command iconv -c -f koi8-r -t utf-8'
alias iconvwu='command iconv -c -f cp1251 -t utf-8'

# grc
if is_exec grc; then
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
alias ls='command ls --color=auto --group-directories-first '
alias la='ls -FA'
alias ll='ls -lha'
alias ld='ls -lhda'

# diff and colordiff
if is_exec colordiff; then
	alias diff='command colordiff -u'
else
	alias diff='command diff -u'
fi
alias rdiff='diff -r'

# mount
alias mountiso='sudo mount -t iso9660 -o loop'
alias mountmdf='sudo mount -o loop'
alias mountnrg='sudo mount -o loop,offset=307200'

# git
alias gss='command git status -s'
alias gdf='command git diff'
alias gci='command git commit -a'
alias gup='command git pull'

# tmux
alias tmux='command tmux -2'
alias atmux='command tmux -2 attach'
# }}}
# {{{ plugins
completion_path='/usr/share/bash-completion/bash_completion'
git_prompt_path='/usr/lib/bash-git-prompt/gitprompt.sh'
if [[ -n ${comp_enabled} && -r ${completion_path} ]]; then
	source ${completion_path}
fi
if [[ -n ${git_enabled} && -r ${git_prompt_path} ]]; then
	GIT_PROMPT_ONLY_IN_REPO=1
	GIT_PROMPT_THEME=Solarized
	source ${git_prompt_path}
fi
unset completion_path git_prompt_path
# }}}
# {{{ traps
# we want to see exit code on error (it also has to be the last entry here)
trap 'printf "\e[0m>> exit \e[1;37m%s\e[0m\n" $?' ERR
# }}}
