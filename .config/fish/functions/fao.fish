function fao --description "Find And Open"
	set FILE (mdfind -onlyin . -name "$argv" | grep -v '\.rsync_cache')
	echo "opening: $FILE"
	gvim $FILE
end
