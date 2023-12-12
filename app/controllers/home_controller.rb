class HomeController < ApplicationController
    def index
      @github_client_id = ENV['GITHUB_CLIENT_ID']
      @google_client_id = ENV['GOOGLE_CLIENT_ID']
    end
  end