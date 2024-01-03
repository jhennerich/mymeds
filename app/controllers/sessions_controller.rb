# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
#    skip_before_action :authenticate_user, only: [:new, :create]
#    before_action :redirect_if_authenticated, only: [:new, :create]
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.find_by_email(params[:user][:email].downcase)

      if @user.provider == 'google_oauth2' 
         redirect_to root_path, flash: { failure: 'Please login with Google' }

      else  

        @user = User.from_registration(params[:user]) 
        if @user.present? && @user.authenticate(params[:user][:password])
         session[:user_id] = @user.id
         redirect_to dashboard_path, flash: { success: 'Logged in successfully' }
        else
         render :new
        end
      end
    end
  
    def destroy
      session[:user_id] = nil
      redirect_to root_path, flash: { success: 'Logged Out' }
    end

    def omniauth
        @user = User.from_omniauth(request.env['omniauth.auth'])
        if @user.valid?
            session[:user_id] = @user.id
            redirect_to dashboard_path, flash: { success: 'Logged in successfully' }
        else
            render :new
        end
    end
end