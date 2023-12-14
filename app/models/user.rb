class User < ApplicationRecord
  has_secure_password
  
  def self.from_omniauth(access_token)

    data = access_token.info
    User.find_or_create_by(provider: access_token.provider, uid: access_token.uid) do |u|

      u.uid = access_token.uid
      u.provider= access_token.provider
      u.full_name = data.name
      u.email = data.email
      u.encrypted_password = SecureRandom.hex(15)
      u.password_digest = access_token.provider

    end
  end
end