enable_vscripts()
{
    local vscripts="${HOME}/vscripts"
    [[ -d ${vscripts} && ${PATH} != *${vscripts}* ]] && export PATH=${PATH}:${vscripts}
}

enable_completion()
{
    local completion_path='/usr/share/bash-completion/bash_completion'
    [[ -r "${completion_path}" ]] && . "${completion_path}"
}

enable_git_prompt()
{
    local git_prompt_path='/usr/lib/bash-git-prompt/gitprompt.sh'
    if [[ -r "${git_prompt_path}" ]]; then
        GIT_PROMPT_FETCH_REMOTE_STATUS=0
        GIT_PROMPT_SHOW_UPSTREAM=1
        GIT_PROMPT_ONLY_IN_REPO=1
        # theme overrides
        if [[ $USER == 'von' ]]; then
            git_prompt_username=""
        else
            git_prompt_username="${pnred}${USER}${preset} "
        fi
        GIT_PROMPT_PREFIX="[ "
        GIT_PROMPT_SUFFIX=" ]"
        GIT_PROMPT_SEPARATOR=" "
        GIT_PROMPT_START="[ ${git_prompt_username}${HOSTNAME}:${pbold}\w${preset} ]"
        GIT_PROMPT_THEME_NAME="Custom"
        GIT_PROMPT_UNTRACKED="${pncyan}u"
        GIT_PROMPT_CHANGED="${pnblue}+"
        GIT_PROMPT_STAGED="${pnyellow}s"
        GIT_PROMPT_CONFLICTS="${pnred}x"
        GIT_PROMPT_STASHED="${pbmagenta}→"
        GIT_PROMPT_CLEAN="${pngreen}."
        GIT_PROMPT_END_USER="\n${pbold}>${preset} "
        GIT_PROMPT_END_ROOT="\n${pnred}>${preset} "
        . "${git_prompt_path}"
    fi
}

enable_vscripts
enable_completion
enable_git_prompt
