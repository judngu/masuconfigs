function gale --description="git add last edited"
	set -l last_file (history --contains "gvim " \
						| grep --color=none "^gvim" \
						| head -n 1 | sed 's/gvim //' \
						| sed -E 's/[[:space:]]+$//')
	git add $last_file
	echo added $last_file
end
