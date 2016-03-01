function got_tag
	set -l tag (git fetch -q upstream; and git tag | grep $argv)
	if [ "$TAG" = "" ]
		echo "nope"
	else
		echo "yup: $TAG"
	end
end

