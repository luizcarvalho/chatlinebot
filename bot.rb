require 'facebook/messenger'
require 'json'
require 'dotenv/load'
require 'pry'
require './lib/firebase_helper'

include Facebook::Messenger
include FirebaseHelper

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV['ACCESS_TOKEN'])

Bot.on :message do |message|
  message.reply(text: 'Hello!')
  if new_message?
    alert_team
  else
    puts 'Mensagem Recente'
  end
  store(message.messaging)
end
