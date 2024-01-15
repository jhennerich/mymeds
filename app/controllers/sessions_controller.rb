# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
 #   skip_before_action :authenticate_user, only: [:new, :create]
 #   before_action :redirect_if_authenticated, only: [:new, :create]
  
    def new
      @user = User.new
    end

    def create

      @user = User.find_by_email!(user_params[:email].downcase)

      if @user.present?
        if @user.provider == 'google_oauth2' 
          redirect_to root_path, flash: { failure: 'Google sign in found please use Google' }
          return
        end

        if @user.present? && @user.authenticate(params[:user][:password])
          session[:user_id] = @user.id
          redirect_to dashboard_path, flash: { success: 'Logged in successfully' }
          return
        end

        if @user.present? && !@user.authenticate(params[:user][:password])
            redirect_to new_session_path, flash: { failure: 'Invaild Email / Password Please try again' }
            return
        end

      else
          redirect_to new_session_path, flash: { failure: 'Invaild Email / Password Please try again' } 
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

    def user_params
      params.require(:user).permit(:email, :password)
    end

    private
 
    def not_found_response(exception)
      redirect_to new_session_path, flash: { failure: 'Invaild Email / Password Please try again' }
    end
end