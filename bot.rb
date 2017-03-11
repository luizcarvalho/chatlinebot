require 'facebook/messenger'
require 'json'
require 'firebase'
require 'dotenv/load'
require 'pry'

include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV['ACCESS_TOKEN'])

@firebase = Firebase::Client.new(ENV['FB_DATABASEURL'], ENV['FB_PRIVATE_KEY'])

 
Bot.on :message do |message|
  message.reply(text: 'Hello!')
  store(message.messaging)
end

def store(message)
  response = @firebase.push('mensagem', message)
  puts response.body unless response.success?
end
