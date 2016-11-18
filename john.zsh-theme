#!/usr/bin/env zsh

# Found on the ZshWiki
# http://zshwiki.org/home/config/prompt

#Emojis! to test run eval "$(curl https://gist.githubusercontent.com/mafintosh/8b420dd5273a137cd6fe/raw/4b5109650a034466ced8ccfc15f19e9a68408b47/emoji-ZSH.sh -sL)"

ZSH_EMOJIS=("😀" "😬" "😁" "😂" "😃" "😄" "😅" "😆" "😇" "😉" "😊" "🙂" "🙃" "☺️" "😋" "😌" "😍" "😘" "😗" "😙" "😚" "😜" "😝" "😛" "🤑" "🤓" "😎" "🤗" "😏" "😶" "😑" "🙄" "🤔" "😳" "😞" "😟" "😠" "😔" "😕" "🙁" "😣" "😖" "😩" "😤" "😮" "😱" "😨" "😰" "😯" "😦" "😧" "😢" "😥" "😪" "😓" "😭" "😲" "🤐" "😷" "😴" "💩" "😺" "😸" "😹" "😻" "😼" "😽" "🙀" "😿" "😾" "👏" "👋" "👂" "👁" "💋" "🕶" "🐶" "🐱" "🐭" "🐹" "🐰" "🐻" "🐼" "🐨" "🐯" "🦁" "🐮" "🐷" "🐽" "🐸" "🐙" "🐵" "🙈" "🙉" "🙊" "🐒" "🐔" "🐧" "🐦" "🐤" "🐣" "🐥" "🐺" "🐗" "🐴" "🦄" "🐝" "🐛" "🐌" "🐞" "🐜" "🕷" "🦂" "🦀" "🐍" "🐢" "🐠" "🐟" "🐡" "🐬" "🐳" "🐋" "🐊" "🐆" "🐅" "🐃" "🐂" "🐄" "🐪" "🐫" "🐘" "🐐" "🐏" "🐑" "🐎" "🐖" "🐀" "🐁" "🐓" "🦃" "🕊" "🐕" "🐩" "🐈" "🐇" "🐿" "🐾" "🐉" "🐲" "🕸" "🍤" "🏇")

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[cyan]%}"
#ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗"
#ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[white]%}✔"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

MODE_INDICATOR="%{$fg_bold[green]%}-- NORMAL --%{$reset_color%} "
RPROMPT=''

function {
    if [[ -n "$SSH_CLIENT" ]]; then
        PROMPT_HOST="$HOST:"
    else
        PROMPT_HOST=''
    fi
}


#PROMPT='%{$fg_bold[cyan]%}%n${ZSH_EMOJIS[$RANDOM % 152]} %m%{$reset_color%}:%{$fg[yellow]%}%c %{$reset_color%}%$(git_prompt_info)%% '
PROMPT='${ZSH_EMOJIS[$RANDOM % 152]}  ${PROMPT_HOST}%{$fg[yellow]%}%c %{$reset_color%}%$(git_prompt_info) $(vi_mode_prompt_info)%% '
