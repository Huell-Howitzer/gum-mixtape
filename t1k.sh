#!/usr/bin/env bash

random_emoji() {
	local emoji_list=("$@")
	local random_index=$((RANDOM % ${#emoji_list[@]}))
	echo "${emoji_list[random_index]}"
}

main() {
	local emojis=(" 🔪 " " 💣 " " 🕯 " " ⚰️  " " ⚱️  " " 🪦 " " 💀 " " 🔥 " " 🥀 " " ☠️  " " 🫗 ")
	local process_names=()
	local process_pids=()
	while read -r pid name; do
		process_names+=("$name")
		process_pids+=("$pid")
	done < <(ps -aux | gum filter --no-limit | awk '{print $2, $11}')
	for ((i = 0; i < ${#process_names[@]}; i++)); do
		selected_pid=${process_pids[i]}
		random_emoji=${emojis[$((RANDOM % ${#emojis[@]}))]}
		kill "$selected_pid" && echo "[$random_emoji]: $selected_pid"
	done
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	# Rest of your script
	main
fi
