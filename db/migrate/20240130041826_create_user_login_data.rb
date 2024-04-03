# frozen_string_literal: true

class CreateUserLoginData < ActiveRecord::Migration[7.1]
  def change
    create_table :user_login_data do |t|
      t.string 'email', default: '', null: false
      t.string 'username', default: '', null: false
      t.string 'password_digest'
      t.string 'encrypted_password', default: '', null: false
      t.timestamps
    end
  end
end
