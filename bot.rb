require 'facebook/messenger'
require 'json'
require 'dotenv/load'
require './lib/firebase_helper'
require './lib/config'

include Facebook::Messenger
include FirebaseHelper
include Config

Facebook::Messenger::Subscriptions.subscribe(access_token: ENV['ACCESS_TOKEN'])

Bot.on :message do |message|
  message_text = nil
  configuration_message = configuration_message(message.messaging)

  message_text = configuration_response if configuration_message

  if !configuration_message && forward(message.messaging)
    message_text = welcome_message
  end

  deliver(message, message_text)
end

def deliver(message, message_text)
  Bot.deliver(
    {
      recipient: message.sender,
      message: message_text
    },
    access_token: ENV['ACCESS_TOKEN']
  )
  message_text
end

def welcome_message
  "Olá seja bem vindo à Brunan Comunicação e Representação. Já avisei a um de nossos \
atendentes que você chegou. Espera um segundinho que você já vai ser atendido 😉"
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
