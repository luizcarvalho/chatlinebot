
module WebmockSupport

  def stub_facebook_access_token
    stub_request(:post, "https://graph.facebook.com/v2.6/me/subscribed_apps?access_token=#{ENV['ACCESS_TOKEN']}").
      to_return(:status => 200, :body => "", :headers => {})
  end

  def stub_slack_webhook
    stub_request(:post, ENV['SLACK_WEBHOOK_URL']).
         to_return(:status => 200, :body => "", :headers => {})

  end

  def stub_firebase_last
    stub_request(:get, "https://vivochatbot.firebaseio.com/messages.json?auth=#{ENV['FB_PRIVATE_KEY']}&limitToLast=1&orderBy=%22timestamp%22").
       to_return(:status => 200, :body => {key: {created_at: 1}}.to_json, :headers => {'Content-Type'=>'application/json'})
  end

  def stub_firebase_create
     stub_request(:post, "https://vivochatbot.firebaseio.com/messages.json?auth=l1zem6NgKXOWxltqKl4wO0ACabwmpnwDtArKc4ll").
       to_return(:status => 200, :body => "", :headers => {})

  end

  def stub_firebase_configuration
       stub_request(:patch, "https://vivochatbot.firebaseio.com/configuration.json?auth=#{ENV['FB_PRIVATE_KEY']}").
         to_return(:status => 200, :body => "", :headers => {})
  end


  def stub_firebase_status(status=nil)
       stub_request(:get, "https://vivochatbot.firebaseio.com/configuration/support_active.json?auth=#{ENV['FB_PRIVATE_KEY']}").
         to_return(:status => 200, :body => status.to_json, :headers => {})
  end


  def facebook_deliver_stub
    stub_request(:post, "https://graph.facebook.com/v2.6/me/messages?access_token=#{ENV['ACCESS_TOKEN']}").
         to_return(:status => 200, :body => "", :headers => {})
  end

end