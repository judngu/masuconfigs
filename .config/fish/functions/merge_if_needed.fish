function merge_if_needed
	set var $argv
	set -q grep_for (git grep-for "#$var"); or set grep_for "NOPE"
	if [ "$grep_for" = "NOPE" ]
		echo "you don't have that."
		echo "Searching github for PR $var"
		merge_pr_here $var 2>/dev/null
	else
		echo "you do have that"
	end
end

