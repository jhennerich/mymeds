class User < ApplicationRecord
  has_secure_password

  def self.from_registration(user_params)

    User.find_or_create_by(email: user_params[:email].downcase) do |u|

      u.uid = (User.maximum(:id) || 0) + 1
      u.provider =  'email_oath'
      u.first_name = user_params[:first_name] 
      u.last_name = user_params[:last_name] 
      u.email = user_params[:email]
      u.encrypted_password = user_params[:password]
      u.password_digest = BCrypt::Password.create(user_params[:password])

    end
  end

  def self.from_omniauth(access_token)

    data = access_token.info
    User.find_or_create_by!(provider: access_token.provider, uid: access_token.uid) do |u|

      u.uid = access_token.uid
      u.provider= access_token.provider

      if data.name
        u.first_name = data.name.split.first
        u.last_name = data.name.split.last

      else
        u.first_name = data.first_name 
        u.last_name = data.last_name 
      end

      u.email = data.email
      u.encrypted_password = SecureRandom.hex(15)
      u.password_digest = access_token.provider

    end
  end
end