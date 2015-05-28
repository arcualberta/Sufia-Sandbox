class UsersController < ApplicationController
  include Sufia::UsersControllerBehavior
  prepend_before_filter :find_user, except: [:index, :search, :notifications_number, :add]
  

	def add
		User.find_or_create_by(email: params[:add])
		redirect_to sufia.profiles_path
	end

  
end
