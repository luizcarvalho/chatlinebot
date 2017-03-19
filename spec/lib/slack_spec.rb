require_relative '../spec_helper'
require_relative '../../lib/slack'


describe Slack do
  it '#send_webhook' do
    stub_slack_webhook
    expect(Slack.send_webhook).to be true
  end

end
