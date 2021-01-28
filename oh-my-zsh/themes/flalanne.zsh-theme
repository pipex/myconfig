# Comment

if [ -z $SSH_CLIENT ]
then
  PROMPT='%{$fg[magenta]%}[%c] %{$reset_color%}'
else
  PROMPT='%{$fg[magenta]%}[%m:%c] %{$reset_color%}'
fi

RPROMPT='%{$fg[magenta]%}$(git_prompt_info)%{$reset_color%} $(git_prompt_status)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%} ✸"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ✓"
ZSH_THEME_GIT_PROMPT_ADDED=""
ZSH_THEME_GIT_PROMPT_MODIFIED=""
ZSH_THEME_GIT_PROMPT_DELETED=""
ZSH_THEME_GIT_PROMPT_RENAMED=""
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%} ▼"
ZSH_THEME_GIT_PROMPT_UNTRACKED=""
