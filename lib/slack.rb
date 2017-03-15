require 'rest-client'
require 'json'

class Slack
  def self.send_webhook
    response = RestClient.post ENV['SLACK_WEBHOOK_URL'], "payload=#{formated_data}", content_type: content_type
    response.code == 200
  end

  def self.content_type
    'application/x-www-form-urlencoded'
  end

  def self.formated_data
    {
      channel: '#atendimentos',
      username: 'LiveChatBot',
      text: webhook_text
    }.to_json
  end

  def self.webhook_text
    "Um novo usuário acaba de iniciar um atendimentos na página do Facebook. \n \
    para acessar a <https://www.facebook.com/brunancr/messages/|área de mensagens da página>."
  end
end
