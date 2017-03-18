require './app'
require_relative 'bot'

set :environment, ENV['RACK_ENV'].to_sym
set :app_file, 'app.rb'
disable :run

log = File.new('logs/sinatra.log', 'a')
STDOUT.reopen(log)
STDERR.reopen(log)

map('/webhook') do
  run Sinatra::Application
  run Facebook::Messenger::Server
end

run Sinatra::Application
