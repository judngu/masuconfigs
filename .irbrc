require 'rubygems'
begin 
	require 'wirble'
	Wirble.init
	Wirble.colorize
rescue LoadError => err
	warn "Couldn't load Wirble: #{err}"
end
