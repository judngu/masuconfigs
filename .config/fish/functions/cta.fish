function cta
	set -l ip (rbm_aws_ip $argv[1] $argv[2])
	ssh app@$ip
end

