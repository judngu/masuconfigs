function sync_layer_cake
	set local_dir ~/workspace/temp/rbm-config-files
	aws s3 sync s3://rbm-config-files $local_dir
	echo "Synced to $local_dir"
end

