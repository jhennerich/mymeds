class SessionsController < ApplicationController
    def new
        if current_user
               redirect_to dashboard_path
        end
    end

    def create
        @user = User.find_by(email: params[:session][:email])
        if @user && @user.authenticate(params[:session][:password])
            session[:user_id] = @user.id
            redirect_to root_path
        else
            flash[:error] = "Invalid username or password"
            redirect_to login_path
        end
    end

    def omniauth
        user = User.from_omniauth(request.env['omniauth.auth'])
        binding.pry
        if user.valid?
            session[:user_id] = user.id
            redirect_to dashboard_path
        else
            redirect_to '/login'
        end
    end

    def destroy
        session.delete :user_id
        redirect_to root_path
    end
end