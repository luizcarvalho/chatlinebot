require './config/environment'

get '/webhook' do
  if params['hub.verify_token'] == ENV['VERIFY_TOKEN']
    params['hub.challenge']
  else
    status 403
  end
end

get '/' do
  'LiveChatBot v1.5'
end
