# frozen_string_literal: true

# app/controllers/registrations_controller.rb
class RegistrationsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  #    skip_before_action :authenticate_user, only: [:new, :create]
  before_action :redirect_if_authenticated, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    #      @user = User.new(user_params)
    @user = User.find_by_email(user_params[:email].downcase)
    if !@user.nil? && @user.valid?
      redirect_to root_path, flash: { alert: 'Account already exists' }
    else
      @user = User.from_registration(user_params)
      if !@user.nil? && @user.valid?
        session[:user_id] = @user.id
        redirect_to root_path, flash: { success: 'Registration successful' }
      else
        @user = User.new(user_params)
        redirect_to new_registration_path, flash: { failure: 'Invalid input' }
      end
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def record_invalid(_exception)
    redirect_to new_registration_path, flash: { failure: 'Invalid Email or Password' }
  end
end
