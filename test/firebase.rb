require_relative '../config/environment'

firebase = Firebase::Client.new(ENV['FB_DATABASEURL'], ENV['FB_PRIVATE_KEY'])
response = firebase.push('todos', name: 'Pick the milk', priority: 1)

puts response.success?
puts response.code
puts response.body
puts response.raw_body
