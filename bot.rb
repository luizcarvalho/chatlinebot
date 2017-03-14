require 'facebook/messenger'
require 'json'
require 'dotenv/load'
require 'pry'
require './lib/firebase_helper'

include Facebook::Messenger
include FirebaseHelper

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV['ACCESS_TOKEN'])

Bot.on :message do |message|
  if forward(message.messaging)
    message.reply(text: welcome_message)
  end
end

def welcome_message
  "Olá seja bem vindo à Brunan Comunicação e Representação. Já avisei a um de nossos \
  atendentes que você chegou. Espera um segundinho que você já vai ser antendido 😉"
end

def nobody_here
  'Olá!! Infelizmente já encerramos nosso expediênte, mas deixe seu telefone ☎ ou celular 📱 \
  que entraremos em contato o mais rápido possível! 🚀'
end

def set_welcome_message
  puts Facebook::Messenger::Thread.set({
                                         setting_type: 'greeting',
                                         greeting: {
                                           text: 'Olá seja bem vindo à Brunan Comunicação e Representação, clique em \
                                           Começar para iniciar o atendimento'
                                         }
                                       }, access_token: ENV['ACCESS_TOKEN'])
end
