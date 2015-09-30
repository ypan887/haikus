require 'rails_helper'

describe 'sessions create successful', type: :request do

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

describe 'sessions create unsuccessful', type: :request do

  before :each do
    OmniAuth.config.mock_auth[:github] = :invalid_credentials
  end

  it 'does not add a session' do
    expect {
      get '/auth/github/callback'
    }.to change{ Session.count }.by(0)

    expect(response.status).to eq(302)
    # You will be redirected back to /auth/failure?message=invalid_credentials.
  end

  it 'does not add a user' do
    expect {
      get '/auth/github/callback'
    }.to change{ User.count }.by(0)
  end

  it 'render status 400' do
    get '/auth/failure'
    expect(response.status).to eq(400)
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
