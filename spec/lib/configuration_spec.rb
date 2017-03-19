require_relative '../spec_helper'
require_relative '../../lib/configuration'


describe Configuration do
  
  before(:all) do
    @firebase = Object.new
    @firebase.extend(Configuration)
  end

  before(:each) do 
    stub_firebase_configuration
    stub_firebase_status
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
    stub_firebase_status(true)
    start_support
    expect(support_active).to be true
  end

  it '#support_active? false when stoped' do
    stub_firebase_status(false)
    stop_support
    expect(support_active).to be false
  end

end
