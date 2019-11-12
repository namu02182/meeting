# frozen_string_literal: true
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    auth = request.env['omniauth.auth']
    
    email = auth['info']['email']
    name = auth['info']['name']
    
    @user = User.find_by(email: email)
    
    unless @user.present?
      @user = User.create(email: email, password: 111111, password_confirmation: 111111, name: name)
    end
    
    sign_in @user
    
    redirect_to root_path
  end
end
