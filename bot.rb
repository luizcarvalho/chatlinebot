require 'facebook/messenger'
require 'json'
require 'dotenv/load'

include Facebook::Messenger

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV['ACCESS_TOKEN'])
 
Bot.on :message do |message|
  message.reply(text: 'Hello!')
end
