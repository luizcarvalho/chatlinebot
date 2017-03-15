require_relative '../spec_helper'
require_relative '../../lib/slack'


describe Slack do

  before(:all) do
    @slack = Object.new
    @slack.extend(Slack)
  end

  it '#send_webhook' do
    expect(@slack.send_webhook).to be true
  end

end
