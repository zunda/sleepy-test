# vim: ts=3
require 'sinatra'

get '/' do
	# GET /?spinup=WAIT_SEC;interval=INTERVAL_SEC;repeat=REPEAT_NUMBER
	par = Hash.new
	%i(spinup inrerval repat).each do |k|
		par[k] = (params[k] || 0).to_i
	end
	spinup =	(par[:spinup] || 0).to_i
	$stdout.puts "Sleeping for #{spinup} sec for spinup"
	$stdout.flush
	sleep spinup
	"Hello, world after #{spinup} seconds"
end
