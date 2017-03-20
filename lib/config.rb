require_relative './firebase_helper'

module Config
  include FirebaseHelper

  def start_support
    update('configuration', support_active: true)
  end

  def stop_support
    update('configuration', support_active: false)
  end

  def support_active?
    response = pull('configuration/support_active')
    response.body
  end

  def configuration_response
    status = support_active? ? 'ativo' : 'inativo'
    "Olá administrador, agora o atendimento está #{status}"
  end

  def configuration_message(message)
    text = message['message']['text']
    if text =~ Regexp.new("iniciar atendimento #{ENV['PASSWORD']}")
      start_support
    elsif text =~ Regexp.new("pausar atendimento #{ENV['PASSWORD']}")
      stop_support
    else
      return false
    end
    true
  end
end
