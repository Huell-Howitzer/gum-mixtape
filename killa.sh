#!/usr/bin/env bash

search_term="${1}"
declare -A process_dict

while read -r pid name; do
	process_dict[$pid]=$name
done < <(ps -aux | grep "$search_term" | awk '{print $2, $11}')

choices=$(gum choose --limit 10 "${process_dict[@]}")

echo "choices: ${choices[@]}"
