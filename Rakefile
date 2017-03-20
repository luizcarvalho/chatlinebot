require './config/environment'
require './app'
require './bot'

desc 'Routes'
task :routes do
  Sinatra::Application.routes.each_pair do |verb, route|
    puts "#{verb} => #{route[0]}"
  end
end
