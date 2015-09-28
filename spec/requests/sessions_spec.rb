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
    expect(body['oauth_token']).to_not be_nil
    expect(body['user_id']).to eq(1)
  end

  after :each do
    OmniAuth.config.mock_auth[:github] = nil
  end
end
