class User < ApplicationRecord
  
  def self.from_omniauth(access_token)

      data = access_token.info
      user = User.where(email: data['email']).first
  
  end
end