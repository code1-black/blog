class AdminController < ApplicationController
	before_action :check_admin_priv
	def show
		@posts = Post.all
  	end 
end