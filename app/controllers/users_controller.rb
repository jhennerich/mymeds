class UsersController < ApplicationController
    def new
        @user = User.new
    end
    
    def create
      user = User.from_signup(user_params)

        if user.valid?
          session[:user_id] = user.id
          redirect_to dashboard_path
        else
          redirect_to login_path
        end
    end
    
    private
    
      def user_params
        params.require(:user).permit(
          :uid, 
          :email,
          :password,
          :password_confirmation,
          :first_name,
          :last_name
          )
      end
end