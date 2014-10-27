# vim: ts=3 sw=3:
require 'sinatra'
require 'newrelic_rpm'

get '/' do
	content_type 'text/plain'
	# GET /?spinup=WAIT_SEC;interval=INTERVAL_SEC;repeat=REPEAT_NUMBER
	par = Hash.new
	%i(spinup interval repeat).each do |k|
		par[k] = (params[k] || 0).to_i
	end
	stream do |out|
		$stdout.puts "Sleeping for #{par[:spinup]} sec for spinup"
		$stdout.flush
		sleep par[:spinup]
		out << "Hello, world after #{par[:spinup]} seconds\n"
		par[:repeat].times do |i|
			msg = "Slept for #{par[:interval]} sec (#{i+1}/#{par[:repeat]})\n"
			sleep par[:interval]
			$stdout.puts msg
			$stdout.flush
			out << msg
		end
		out << "Good bye for now\n"
	end
end
