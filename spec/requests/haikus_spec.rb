require 'rails_helper'

describe 'haikus', type: :request do

  describe 'index' do
    before :each do
      haikus_list = FactoryGirl.create_list(:haiku, 5)
      get '/haikus'
    end
    it 'should have an endpoint' do
      expect(response).to be_success
    end
    it 'should return an array of haikus' do
      body = JSON.parse(response.body)
      expect(body['data'].length).to eq(5)
    end
  end

  describe 'show' do
    let(:haiku) {FactoryGirl.create(:haiku)}
    before :each do
      get "/haikus/#{haiku.id}"
    end
    it 'should have an endpoint' do
      expect(response).to be_success
    end
    it 'should return the correct haiku' do
      body = JSON.parse(response.body)
      expect(body['data']['id'].to_i).to eq(haiku.id)
    end
  end

  describe 'create' do
    it 'should create a new haiku' do
      expect{ post '/haikus'}.to change { Haiku.count }.by(1)
      expect(response.status).to eq(201)
    end
=begin
    it 'should not create a new haiku without a line' do
      #spec for making sure haikus wont be created without a line
    end
=end
  end

  describe 'update' do
    #update spec will be written when haikus are created with a new line
  end

  describe 'destroy' do
    let!(:haiku) { FactoryGirl.create(:haiku) }
    it "should delete the haiku" do
      expect{ delete "/haikus/#{haiku.id}", format: :json }.to change{Haiku.count}.by(-1)
    end
  end


end
