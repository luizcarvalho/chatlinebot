require_relative '../spec_helper'
require_relative '../../lib/firebase_helper'

describe FirebaseHelper do

  before(:all) do
    @firebase = Object.new
    @firebase.extend(FirebaseHelper)
  end

  before(:each) do
    stub_firebase_last
  end

  let(:facebook_message) {
    {
      "sender"=>{"id"=>"1316244871796928"}, "recipient"=>{"id"=>"1002040779848208"},
      "timestamp"=>(Time.new.to_i),
      "message"=>{"mid"=>"mid.1489256475431:0372ce8f46", "seq"=>50961, "text"=>"lerrroyy jenkins"}
    }
  }

  it 'ENV variables must be setteds' do
    expect(ENV['FB_DATABASEURL']).not_to be nil
    expect(ENV['FB_PRIVATE_KEY']).not_to be nil
  end

  it '#client' do
    expect(@firebase.client).not_to be nil
  end

  it '#new_message?' do
    # agora tem q ser maior que ultima+1
    stub_firebase_last(-60)
    expect(@firebase.new_message?).to be(true)
  end


end
