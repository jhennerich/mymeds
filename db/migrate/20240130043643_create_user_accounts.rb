# frozen_string_literal: true

class CreateUserAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :user_accounts do |t|
      t.string :first_name
      t.string :last_name
      t.integer 'user_id', null: false

      t.timestamps
    end
    add_foreign_key 'user_accounts', 'user_login_data', column: 'user_id'
  end
end
