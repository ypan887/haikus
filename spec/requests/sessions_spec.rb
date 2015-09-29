require 'rails_helper'

describe 'sessions', type: :request do

  before :each do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
  end

  it 'creates a session' do
    expect {
      get '/auth/github/callback'
    }.to change{ Session.count }.by(1)

    body = JSON.parse(response.body)
    expect(body['data']['attributes']['oauth_token']).to_not be_nil
    expect(body['data']['attributes']['user_id']).to eq(1)
  end

  it 'adds a user' do
    expect {
      get '/auth/github/callback'
    }.to change{ User.count }.by(1)
  end

end

describe 'sessions destroy', type: :request do
  session = Session.create(user_id: 1, oauth_token: "MyString")

  it 'deletes a session' do
    expect {
      delete "/sessions/#{session.id}"
    }.to change{ Session.count }.by(-1)
    expect(response.status).to eq(204)
  end
end
