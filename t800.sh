#!/usr/bin/env bash

search_term=$(gum input --placeholder "search")
declare -A process_dict

while read -r pid name; do
	process_dict[$name]=$pid
done < <(ps -aux | grep "$search_term" | awk '{print $2, $11}')

choices=$(printf '%s\n' "${!process_dict[@]}" | gum choose --limit 10)

echo "Selected Process Names:"
for choice in $choices; do
	selected_pid=${process_dict[$choice]}
	echo "Process Name: $choice, PID: $selected_pid"
done
