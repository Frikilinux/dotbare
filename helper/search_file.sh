#!/usr/bin/env bash
#
# search local file or directory taking consideration of optional dependency

#######################################
# search local file
# Arguments:
#   $1: string, f or d, search file or directory
# Outputs:
#   A user selected file path
#######################################
function search_file() {
  local search_type="$1" mydir
  mydir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
  if [[ "${search_type}" == "f" ]]; then
    find . ~ -type f | sed "s|\./||g" | fzf --layout reverse --multi --preview "${mydir}/preview.sh {}"
  elif [[ "${search_type}" == "d" ]]; then
    if command -v tree &>/dev/null; then
      find . ~ -type d | awk '{if ($0 != "." && $0 != "./.git"){gsub(/^\.\//, "", $0);print $0}}' | fzf --layout reverse --multi --preview "tree -L 1 -C --dirsfirst {}"
    else
      find . ~ -type d | awk '{if ($0 != "." && $0 != "./.git"){gsub(/^\.\//, "", $0);print $0}}' | fzf --layout reverse --multi
    fi
  fi
}
