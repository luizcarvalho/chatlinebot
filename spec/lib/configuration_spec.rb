require_relative '../spec_helper'
require_relative '../../lib/configuration'


describe Configuration do
  
  before(:all) do
    @firebase = Object.new
    @firebase.extend(Configuration)
  end

  let(:start_support) { @firebase.start_support }
  let(:stop_support) { @firebase.stop_support }
  let(:support_active) { @firebase.support_active? }

  it '#start_support' do
    response = start_support
    expect(response.success?).to be true
  end

  it '#stop_support' do
    response = stop_support
    expect(response.success?).to be true
  end

  it '#support_active? true when started' do
    start_support
    expect(support_active).to be true
  end

  it '#support_active? false when stoped' do
    stop_support
    expect(support_active).to be false
  end

end
