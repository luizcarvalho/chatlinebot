require_relative 'spec_helper'
require_relative '../bot'

describe Bot do
  let(:messaging) { {"message"=>{"text"=>"hello"}} }

  it '#message_is_a_phone?' do
    valids_phones = [
      '81329588',
      '8132 9588',
      '8132-9588'
    ]

    valids_phones.each do |phone|
      messaging['message']['text'] = phone
      expect(message_is_a_phone?(messaging)).to be_truthy
    end
    
  end

end