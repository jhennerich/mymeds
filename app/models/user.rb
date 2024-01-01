class User < ApplicationRecord
#  has_secure_password

  def self.from_registration(user_params)
    User.find_or_create_by(email: user_params[:email]) do |u|

      u.uid = user_params[:uid]
      u.provider =  'email_oath'
      u.first_name = user_params[:first_name] 
      u.last_name = user_params[:last_name] 
      u.email = user_params[:email]
      u.encrypted_password = user_params[:password]
      u.password_digest = user_params[:password]

    end
  end

  def self.from_omniauth(access_token)

    data = access_token.info
    User.find_or_create_by!(provider: access_token.provider, uid: access_token.uid) do |u|

      u.uid = access_token.uid
      u.provider= access_token.provider
#      u.full_name = data.name
      u.first_name = data.first_name 
      u.last_name = data.last_name 
      u.email = data.email
      u.encrypted_password = SecureRandom.hex(15)
      u.password_digest = access_token.provider

    end
  end
end