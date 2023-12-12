class SessionsController < ApplicationController
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
end
