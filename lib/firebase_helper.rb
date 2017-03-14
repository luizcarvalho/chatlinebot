require 'firebase'

module FirebaseHelper
  

  MINUTES_INTERVAL = 1
  TIME_TO_NEW_MESSAGE = MINUTES_INTERVAL * 60

  def client
    @firebase ||= Firebase::Client.new(ENV['FB_DATABASEURL'], ENV['FB_PRIVATE_KEY'])
  end

  def forward(message)
    alerted = false
    alerted = alert_team if new_message?
    store(message)
    alerted
  end

  def new_message?
    last_message = request_last_message
    return false unless last_message

    current_time = time_now
    limit_time = calculate_limit_time(last_message)
    current_time > limit_time
  end

  def calculate_limit_time(fb_time)
    (fb_time['created_at'] || 0) + TIME_TO_NEW_MESSAGE
  end

  def request_last_message
    response = client.get('messages', orderBy: '"timestamp"', limitToLast: 1)
    response.body.values.first if response.success? && response.body
  end

  def alert_team
    puts 'messagem sended to Slack Team'
    true
  end

  def store(message)
    response = client.push('messages', simplify_data(message))
    puts response.body unless response.success?
  end

  def simplify_data(message)
    {
      sender_id: message['sender']['id'],
      timestamp: message['timestamp'],
      created_at: time_now,
      message_text: message['message']['text']
    }
  end

  def time_now
    Time.now.to_i
  end
end