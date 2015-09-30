class SessionsController < ApplicationController
  def create
    token = auth_hash.credentials.token
    email = auth_hash.info.email

    user = User.find_or_create_by(email: email)
    session = Session.create(oauth_token: token, user_id: user.id)
    render json: session
  end

  def auth_failed
    render json: '400', status: 400
  end

  def destroy
    session = Session.find_by(id: params[:id])
    session.destroy

    head 204
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
