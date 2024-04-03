# frozen_string_literal: true

class UserAccount < ApplicationRecord
  belongs_to :user_login_details
end
