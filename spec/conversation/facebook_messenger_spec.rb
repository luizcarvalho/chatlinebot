require 'spec_helper'
RSpec.describe 'Facebook Messenger', type: :request do
  before(:each) do
    facebook_deliver_stub    
    stub_firebase_last
    stub_slack_webhook
    stub_firebase_create
    stub_firebase_configuration
  end

  context 'atentimento ativo' do
    before(:each) do
      stub_firebase_status(true)
    end

    it 'say any answer welcome' do
      chatbot = ChatbotHelper.new('hello')
      header chatbot.signature_header, chatbot.signature

      post '/webhook', chatbot.payload
      expect(JSON.parse(last_response.body)).to include('Já avisei a um de nossos')
    end


    it 'say configuration command iniciar atendimento receive configuration iniciar feedback' do
      chatbot = ChatbotHelper.new('/iniciar atendimento bcr2017')
      header chatbot.signature_header, chatbot.signature

      post '/webhook', chatbot.facebook_incoming_payload
      expect(JSON.parse(last_response.body)).to include('o atendimento está ativo')
    end

    it 'say two messages welcome message only for first' do
      chatbot = ChatbotHelper.new('twice message')
      header chatbot.signature_header, chatbot.signature

      pending 'calcular tempo certinho'
      post '/webhook', chatbot.facebook_incoming_payload
      expect(JSON.parse(last_response.body)).to include('Já avisei a um de nossos')

      post '/webhook', chatbot.facebook_incoming_payload
      expect(JSON.parse(last_response.body)).to be nil
    end
  end


  context 'atentimento inativo' do
    before(:each) do
      stub_firebase_status(false)
    end

    it 'say configuration command to inativar atentimento receive configuration initivar feedback' do
      chatbot = ChatbotHelper.new('/pausar atendimento bcr2017')
      header chatbot.signature_header, chatbot.signature

      post '/webhook', chatbot.facebook_incoming_payload
      expect(JSON.parse(last_response.body)).to include('o atendimento está inativo')
    end

    it 'say anything receive take_contact answer' do
      chatbot = ChatbotHelper.new('hello')
      header chatbot.signature_header, chatbot.signature

      post '/webhook', chatbot.facebook_incoming_payload
      expect(JSON.parse(last_response.body)).to include('deixe seu telefone')
    end
  end

end
