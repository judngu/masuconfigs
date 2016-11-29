function gdef --description="grep for ruby function definitions"
	grep -r $argv | grep def | grep -v "tags:"
end
