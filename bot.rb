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

  unless configuration_message
    support_active = support_active?
    message_text = if support_active && forward(message.messaging)
                     welcome_message
                   elsif !support_active
                     if message_is_a_phone?(message.messaging)
                       ending_message
                     else
                       nobody_here
                     end
                   end
  end
  begin
    send_to_messenger(message, message_text)
  rescue => e
    puts "ERRO: #{e.message}"
  end
end

def message_is_a_phone?(messaging)
  messaging.dig('message', 'text').to_s =~ Regexp.new(/([0-9]{4})/)
end

def send_to_messenger(message, message_text)
  Bot.deliver(
    {
      recipient: message.sender,
      message: { text: message_text }
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
  "Olá!! Infelizmente já encerramos nosso expediênte, mas deixe seu telefone ☎ ou celular 📱 \
que entraremos em contato o mais rápido possível! 🚀"
end

def ending_message
  'Obrigado! entraremos em contato assim que possível!'
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
