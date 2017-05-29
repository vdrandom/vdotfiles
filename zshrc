# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# {{{ settings
local_bin="${HOME}/.local/bin"
[[ -d "${local_bin}" && "${PATH}" != *${local_bin}* ]] && export PATH="${PATH}:${local_bin}"

setopt APPEND_HISTORY EXTENDED_HISTORY HIST_IGNORE_DUPS EXTENDED_GLOB AUTO_CD
setopt AUTO_PUSHD PRINT_EXIT_VALUE
unsetopt BEEP NO_MATCH NOTIFY

SAVEHIST=1000
HISTSIZE=1000
HISTFILE="${HOME}/.histfile"

# completion
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
# git info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr " %F{2}S%f"
zstyle ':vcs_info:*' unstagedstr " %F{1}U%f"
zstyle ':vcs_info:*' formats " { %F{4}%r%f %F{3}%b%f%u%c }"

export MYSQL_PS1="mysql [\d]> "
export SSH_AUTH_SOCK="${HOME}/.ssh/ssh_auth_sock"
export TIME_STYLE='long-iso'

export LANG='en_US.utf8'
export LANGUAGE="$LANG"
export EDITOR='vim'
export PAGER='less -R'
export LS_COLORS='no=00:fi=00:di=34:ow=34;40:ln=35:pi=30;44:so=35;44:do=35;44:bd=33;44:cd=37;44:or=05;37;41:mi=05;37;41:ex=01;31:*.cmd=01;31:*.exe=01;31:*.com=01;31:*.bat=01;31:*.reg=01;31:*.app=01;31:*.txt=32:*.org=32:*.md=32:*.mkd=32:*.h=32:*.c=32:*.C=32:*.cc=32:*.cpp=32:*.cxx=32:*.objc=32:*.sh=32:*.csh=32:*.zsh=32:*.el=32:*.vim=32:*.java=32:*.pl=32:*.pm=32:*.py=32:*.rb=32:*.hs=32:*.php=32:*.htm=32:*.html=32:*.shtml=32:*.erb=32:*.haml=32:*.xml=32:*.rdf=32:*.css=32:*.sass=32:*.scss=32:*.less=32:*.js=32:*.coffee=32:*.man=32:*.0=32:*.1=32:*.2=32:*.3=32:*.4=32:*.5=32:*.6=32:*.7=32:*.8=32:*.9=32:*.l=32:*.n=32:*.p=32:*.pod=32:*.tex=32:*.bmp=33:*.cgm=33:*.dl=33:*.dvi=33:*.emf=33:*.eps=33:*.gif=33:*.jpeg=33:*.jpg=33:*.JPG=33:*.mng=33:*.pbm=33:*.pcx=33:*.pdf=33:*.pgm=33:*.png=33:*.ppm=33:*.pps=33:*.ppsx=33:*.ps=33:*.svg=33:*.svgz=33:*.tga=33:*.tif=33:*.tiff=33:*.xbm=33:*.xcf=33:*.xpm=33:*.xwd=33:*.xwd=33:*.yuv=33:*.aac=33:*.au=33:*.flac=33:*.mid=33:*.midi=33:*.mka=33:*.mp3=33:*.mpa=33:*.mpeg=33:*.mpg=33:*.ogg=33:*.ra=33:*.wav=33:*.anx=33:*.asf=33:*.avi=33:*.axv=33:*.flc=33:*.fli=33:*.flv=33:*.gl=33:*.m2v=33:*.m4v=33:*.mkv=33:*.mov=33:*.mp4=33:*.mp4v=33:*.mpeg=33:*.mpg=33:*.nuv=33:*.ogm=33:*.ogv=33:*.ogx=33:*.qt=33:*.rm=33:*.rmvb=33:*.swf=33:*.vob=33:*.wmv=33:*.doc=31:*.docx=31:*.rtf=31:*.dot=31:*.dotx=31:*.xls=31:*.xlsx=31:*.ppt=31:*.pptx=31:*.fla=31:*.psd=31:*.7z=1;35:*.apk=1;35:*.arj=1;35:*.bin=1;35:*.bz=1;35:*.bz2=1;35:*.cab=1;35:*.deb=1;35:*.dmg=1;35:*.gem=1;35:*.gz=1;35:*.iso=1;35:*.jar=1;35:*.msi=1;35:*.rar=1;35:*.rpm=1;35:*.tar=1;35:*.tbz=1;35:*.tbz2=1;35:*.tgz=1;35:*.tx=1;35:*.war=1;35:*.xpi=1;35:*.xz=1;35:*.z=1;35:*.Z=1;35:*.zip=1;35:*.ANSI-30-black=30:*.ANSI-01;30-brblack=01;30:*.ANSI-31-red=31:*.ANSI-01;31-brred=01;31:*.ANSI-32-green=32:*.ANSI-01;32-brgreen=01;32:*.ANSI-33-yellow=33:*.ANSI-01;33-bryellow=01;33:*.ANSI-34-blue=34:*.ANSI-01;34-brblue=01;34:*.ANSI-35-magenta=35:*.ANSI-01;35-brmagenta=01;35:*.ANSI-36-cyan=36:*.ANSI-01;36-brcyan=01;36:*.ANSI-37-white=37:*.ANSI-01;37-brwhite=01;37:*.log=01;32:*~=01;32:*#=01;32:*.bak=01;33:*.BAK=01;33:*.old=01;33:*.OLD=01;33:*.org_archive=01;33:*.off=01;33:*.OFF=01;33:*.dist=01;33:*.DIST=01;33:*.orig=01;33:*.ORIG=01;33:*.swp=01;33:*.swo=01;33:*,v=01;33:*.gpg=34:*.gpg=34:*.pgp=34:*.asc=34:*.3des=34:*.aes=34:*.enc=34:'

is_exec() { [[ -x $(whence ${1}) ]]; }
# }}}
# {{{ prompt
new_line='
'
lb='[ '
rb=' ]'
bb=':'
prompt_user='%(1000#..%F{1}%n%f )'
prompt_host='%m'
prompt_cwd='%F{8}%d%f'
prompt_bang='%(!.%F{1}>%f.%F{8}>%f) '
prompt_jobs='%(1j. jobs:%F{1}%j%f.)'
precmd() {
    case ${TERM} in
        xterm*|rxvt*)
            printf "\033]0;%s@%s\007" "${USER}" "${HOST%%.*}"
            ;;
        screen*|tmux)
            printf "\033k%s@%s\033\\" "${USER}" "${HOST%%.*}"
            ;;
    esac
    vcs_info
    PROMPT="[ ${prompt_user}${prompt_host}${bb}${prompt_cwd}${prompt_jobs} ]${vcs_info_msg_0_}${new_line}${prompt_bang}"
}
PROMPT2='%b%f%_%F{2}>%f%b '
PROMPT3='%b%f?%F{2}#%f%b '
PROMPT4='%b%f+%N:%i%F{2}>%f%b '
# }}}
# {{{ key bindings
bindkey -e
# urxvt
bindkey '^[[7~'   beginning-of-line                   # home
bindkey '^[[8~'   end-of-line                         # end
bindkey '^[Oc'    forward-word                        # ctrl + right
bindkey '^[Od'    backward-word                       # ctrl + left
bindkey '^[[3^'   delete-word                         # ctrl + del
# screen
bindkey '^[[1~'   beginning-of-line                   # home
bindkey '^[[4~'   end-of-line                         # end
# xterm
bindkey '^[[H'    beginning-of-line                   # home
bindkey '^[[F'    end-of-line                         # end
# most of them (but not urxvt)
bindkey '^[[1;5C' forward-word                        # ctrl + right
bindkey '^[[1;5D' backward-word                       # ctrl + left
bindkey '^[[3;5~' delete-word                         # ctrl + del
# all of them
bindkey '^[[5~'   backward-word                       # page up
bindkey '^[[6~'   forward-word                        # page down
bindkey '^[[3~'   delete-char                         # del
bindkey '^R'      history-incremental-search-backward # ctrl + r
bindkey '^[m'     copy-prev-shell-word                # alt + m
bindkey -s '^j'   '^atime ^m'                         # ctrl + j
# }}}
# {{{ functions
gdiff() { /usr/bin/git diff --color "$@"; }
gdf()
{
    local fancydiff='/usr/bin/diff-so-fancy'
    local githighlight='/usr/share/git/diff-highlight/diff-highlight'
    if [[ -x ${fancydiff} ]]; then
        gdiff "$@" | ${fancydiff} | less --tabs=4 -RSFX
    elif [[ -x ${githighlight} ]]; then
        gdiff "$@" | ${githighlight} | less --tabs=4 -RSFX
    else
        gdiff "$@"
    fi
}
# }}}
# {{{ aliases
alias less='command less -R'
alias ltail='command less -R +F'
alias cower='command cower -c'
alias pacman='command pacman --color=auto'
alias rgrep='command grep --exclude-dir=\.git -R'
alias hist='command fc -l -1'
alias beep='printf "\007"'
alias fixterm='printf "c"'
alias vi='command vim'
alias pg-linux-client='command sudo -u postgres psql'
alias mysql='command mysql --sigint-ignore'

# iconv
alias iconvwk='command iconv -c -f cp1251 -t koi8-r'
alias iconvuk='command iconv -c -f utf-8 -t koi8-r'
alias iconvku='command iconv -c -f koi8-r -t utf-8'
alias iconvwu='command iconv -c -f cp1251 -t utf-8'

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
alias rdiff='command diff -r'

# mount
alias mountiso='sudo mount -t iso9660 -o loop'
alias mountmdf='sudo mount -o loop'
alias mountnrg='sudo mount -o loop,offset=307200'

# git
alias gci='command git commit'
alias gsl='command git stash list'
alias gss='command git status -sbu'
alias gup='command git pull'

# tig
alias gsi='command tig status'

# tmux
if is_exec tmux; then
    alias tmux='command tmux -2'
    alias atmux='command tmux -2 attach'
fi

# screen
alias rscreen='command screen -Dr'
alias scr='command screen sudo -Es'

# grc
grc_rc='/etc/grc.zsh'
[[ -r ${grc_rc} ]] && . ${grc_rc}
# }}}
# {{{ global aliases
alias -g L='| less -R'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g PV='| pv |'
alias -g WCL='| wc -l'
alias -g NCL='| nc -l 17777'

# redirection
alias -g NO='1> /dev/null'
alias -g NE='2> /dev/null'
alias -g EO='2> &1'
alias -g OE='1> &2'
alias -g TEE='>&1 >>'

# iconv
alias -g WK='| iconvwk'
alias -g UK='| iconvuk'
alias -g KU='| iconvku'
alias -g WU='| iconvwu'
# }}}
# {{{ suffix aliases
editor=${EDITOR}
text=( 'txt' 'xml' 'cfg' 'cnf' 'conf' 'ini' 'erb' 'pp' )
for i in ${text[@]}; do
    alias -s ${i}=${editor}
done

player='mpv'
media=( 'mkv' 'mp4' 'avi' 'mpg' 'mp3' 'ogg' 'mpeg' 'mov' 'webm' 'flv' )
for i in ${media[@]}; do
    alias -s ${i}=${player}
done

viewer='eog'
image=( 'jpg' 'png' 'gif' 'bmp' 'jpeg' )
for i in ${image[@]}; do
    alias -s ${i}=${viewer}
done

# wine:
if [[ ${OSTYPE} != 'cygwin' ]]; then
    alias -s exe=wine
fi
# }}}
