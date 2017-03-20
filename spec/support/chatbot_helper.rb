require 'pry'
require 'facebook/messenger'
require 'rack/test'

class ChatbotHelper
  attr_reader :message, :signature, :signature_header, :payload

  def initialize(message)
    @message = message
    @payload = facebook_incoming_payload
    @signature = signature_for(@payload)
    @signature_header = 'X_HUB_SIGNATURE'
  end

  def facebook_incoming_payload
    {
      'object' => 'page',
      'entry' =>
      [
        { 'id' => '0000000000000001',
          'time' => Time.now.to_i,
          'messaging' =>
          [
            {
              'sender' => { 'id' => '0000000000000001' },
              'recipient' => { 'id' => '0000000000000002' },
              'timestamp' => Time.now.to_i,
              'message' => { 'mid' => 'mid.1:abcdef', 'seq' => 1, 'text' => @message }
            }
          ]
        }
      ]
    }.to_json
  end

  def recreate_signature!
    @signature = signature_for(@payload)
  end

  # Returns a String describing its signature.
  def signature_for(string)
    format('sha1=%s'.freeze, generate_hmac(string))
  end

  # Generate a HMAC signature for the given content.
  def generate_hmac(content)
    content_json = JSON.parse(content, symbolize_names: true)
    facebook_page_id = content_json[:entry][0][:id]
    OpenSSL::HMAC.hexdigest('sha1'.freeze,
                            app_secret_for(facebook_page_id),
                            content)
  end

  # Returns a String describing the bot's configured app secret.
  def app_secret_for(facebook_page_id)
    Facebook::Messenger.config.provider.app_secret_for(facebook_page_id)
  end
end
