# vim: ts=3
require 'sinatra'

get '/' do
	# GET /?spinup=WAIT_SEC
	spinup =	(params[:spinup] || 0).to_i
	$stdout.puts "Sleeping for #{spinup} sec for spinup"
	$stdout.flush
	sleep spinup
	"Hello, world after #{spinup} seconds"
end
