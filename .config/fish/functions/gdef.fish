function gdef --description="grep for ruby function definitions"
	grep -r $argv * | grep def | grep -v "tags:"
	# todo figure out how to make it support 
	# gdef foo in/this/folder/
	# and have it result in 
	# grep -r foo in/this/folder/* | grep def | grep -v "tags:"
end
