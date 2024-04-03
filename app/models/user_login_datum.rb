# frozen_string_literal: true

class UserLoginDatum < ApplicationRecord
  has_one :user_account
end
