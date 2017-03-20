http://recipes.sinatrarb.com/p/deployment/apache_with_passenger
CHANGE:
  /home/desenvolvimento/.rvm/gems/ruby-2.3.1/gems/facebook-messenger-0.11.1/lib/facebook/messenger/server.rb

      def trigger(events)
        # Facebook may batch several items in the 'entry' array during
        # periods of high load.
        events['entry'.freeze].each do |entry|
          # If the application has subscribed to webhooks other than Messenger,
          # 'messaging' won't be available and it is not relevant to us.
          next unless entry['messaging'.freeze]
          # Facebook may batch several items in the 'messaging' array during
          # periods of high load.
          entry['messaging'.freeze].each do |messaging|
            @response.write(Facebook::Messenger::Bot.receive(messaging).to_json)
          end
        end
      end
