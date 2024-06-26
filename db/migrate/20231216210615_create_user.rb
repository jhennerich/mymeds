# frozen_string_literal: true

class CreateUser < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'plpgsql'

    create_table 'users', force: :cascade do |t|
      t.string 'email', default: '', null: false
      t.string 'password_digest'
      t.string 'encrypted_password', default: '', null: false
      t.string 'uid', null: false
      t.string 'first_name'
      t.string 'last_name'
      t.string 'provider'
      t.string 'reset_password_token'
      t.datetime 'reset_password_sent_at'
      t.datetime 'remember_created_at'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index ['email'], name: 'index_users_on_email', unique: true
      t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
      t.index ['uid'], name: 'index_users_on_uid', unique: true
    end
  end
end
