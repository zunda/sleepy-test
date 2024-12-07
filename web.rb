require 'sinatra'
require 'sinatra/streaming'

usage='/?spinup=<WAIT_SEC>&interval=<INTERVAL_SEC>&repeat=<REPEAT_NUMBER>'

get '/' do
  content_type 'text/plain'
  par = Hash.new
  %i(spinup interval repeat).each do |k|
    par[k] = (params[k] || 0).to_i
  end
  stream do |out|
    $stdout.puts "Sleeping for #{par[:spinup]} sec for spinup"
    $stdout.flush
    sleep par[:spinup]
    out << "Good morning, world!, after #{par[:spinup]} seconds of sleep\n"
    out.flush
    par[:repeat].times do |i|
      msg = "Slept for #{par[:interval]} sec (#{i+1}/#{par[:repeat]})\n"
      sleep par[:interval]
      $stdout.puts msg
      $stdout.flush
      out << msg
      out.flush
    end
    out << usage + "\n"
    out.flush
  end
end
