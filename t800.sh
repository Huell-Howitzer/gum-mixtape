#!/usr/bin/env bash

random_emoji() {
	local emoji_list=("$@")
	local random_index=$((RANDOM % ${#emoji_list[@]}))
	echo "${emoji_list[random_index]}"
}

main() {
	export GUM_CHOOSE_ORDERED=""
	export GUM_CHOOSE_HEIGHT=""
	export GUM_CHOOSE_CURSOR="⌖"
	export GUM_CHOOSE_HEADER=""
	export GUM_CHOOSE_CURSOR_PREFIX="🫢"
	export GUM_CHOOSE_SELECTED_PREFIX="😵"
	export GUM_CHOOSE_UNSELECTED_PREFIX="😀"
	export GUM_CHOOSE_SELECTED="💥"
	export GUM_CHOOSE_CURSOR_BACKGROUND=""
	export GUM_CHOOSE_CURSOR_FOREGROUND=""
	export GUM_CHOOSE_CURSOR_BORDER=""
	export GUM_CHOOSE_CURSOR_BORDER_BACKGROUND=""
	export GUM_CHOOSE_CURSOR_BORDER_FOREGROUND=""
	export GUM_CHOOSE_CURSOR_ALIGN=""
	export GUM_CHOOSE_CURSOR_HEIGHT=""
	export GUM_CHOOSE_CURSOR_WIDTH=""
	export GUM_CHOOSE_CURSOR_MARGIN=""
	export GUM_CHOOSE_CURSOR_PADDING=""
	export GUM_CHOOSE_CURSOR_BOLD=""
	export GUM_CHOOSE_CURSOR_FAINT=""
	export GUM_CHOOSE_CURSOR_ITALIC=""
	export GUM_CHOOSE_CURSOR_STRIKETHROUGH=""
	export GUM_CHOOSE_CURSOR_UNDERLINE=""
	export GUM_CHOOSE_HEADER_BACKGROUND=""
	export GUM_CHOOSE_HEADER_FOREGROUND=""
	export GUM_CHOOSE_HEADER_BORDER=""
	export GUM_CHOOSE_HEADER_BORDER_BACKGROUND=""
	export GUM_CHOOSE_HEADER_BORDER_FOREGROUND=""
	export GUM_CHOOSE_HEADER_ALIGN=""
	export GUM_CHOOSE_HEADER_HEIGHT=""
	export GUM_CHOOSE_HEADER_WIDTH=""
	export GUM_CHOOSE_HEADER_MARGIN=""
	export GUM_CHOOSE_HEADER_PADDING=""
	export GUM_CHOOSE_HEADER_BOLD=""
	export GUM_CHOOSE_HEADER_FAINT=""
	export GUM_CHOOSE_HEADER_ITALIC=""
	export GUM_CHOOSE_HEADER_STRIKETHROUGH=""
	export GUM_CHOOSE_HEADER_UNDERLINE=""
	export GUM_CHOOSE_ITEM_BACKGROUND=""
	export GUM_CHOOSE_ITEM_FOREGROUND=""
	export GUM_CHOOSE_ITEM_BORDER=""
	export GUM_CHOOSE_ITEM_BORDER_BACKGROUND=""
	export GUM_CHOOSE_ITEM_BORDER_FOREGROUND=""
	export GUM_CHOOSE_ITEM_ALIGN=""
	export GUM_CHOOSE_ITEM_HEIGHT=""
	export GUM_CHOOSE_ITEM_WIDTH=""
	export GUM_CHOOSE_ITEM_MARGIN=""
	export GUM_CHOOSE_ITEM_PADDING=""
	export GUM_CHOOSE_ITEM_BOLD=""
	export GUM_CHOOSE_ITEM_FAINT=""
	export GUM_CHOOSE_ITEM_ITALIC=""
	export GUM_CHOOSE_ITEM_STRIKETHROUGH=""
	export GUM_CHOOSE_ITEM_UNDERLINE=""
	export GUM_CHOOSE_SELECTED_BACKGROUND=""
	export GUM_CHOOSE_SELECTED_FOREGROUND=""
	export GUM_CHOOSE_SELECTED_BORDER=""
	export GUM_CHOOSE_SELECTED_BORDER_BACKGROUND=""
	export GUM_CHOOSE_SELECTED_BORDER_FOREGROUND=""
	export GUM_CHOOSE_SELECTED_ALIGN=""
	export GUM_CHOOSE_SELECTED_HEIGHT=""
	export GUM_CHOOSE_SELECTED_WIDTH=""
	export GUM_CHOOSE_SELECTED_MARGIN=""
	export GUM_CHOOSE_SELECTED_PADDING=""
	export GUM_CHOOSE_SELECTED_BOLD=""
	export GUM_CHOOSE_SELECTED_FAINT=""
	export GUM_CHOOSE_SELECTED_ITALIC=""
	export GUM_CHOOSE_SELECTED_STRIKETHROUGH=""
	export GUM_CHOOSE_SELECTED_UNDERLINE=""

	local emojis=(" 🔪 " " 💣 " " 🕯 " " ⚰️  " " ⚱️  " " 🪦 " " 💀 " " 🔥 " " 🥀 " " ☠️  " " 🫗 ")
	local process_names=()
	local process_pids=()
	declare -A process_dict
	search_term=$(gum input --placeholder "search")

	while read -r line; do
		processes=$(echo "$line" | awk '{print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12}')
		process_dict["$processes"]=$line
	done < <(ps -aux | grep "$search_term")

	choices=$(printf '%s\n' "${!process_dict[@]}" | gum choose --limit 10)
	pid_list=($(echo "$choices" | awk '{print $2}'))
	for pid in "${pid_list[@]}"; do
		kill "$pid"
		echo "$(random_emoji "${emojis[@]}"): $pid"
	done
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	# Rest of your script
	main
fi
