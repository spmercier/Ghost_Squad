class UsersController < ApplicationController
	def index

	end
	def new
		@user = User.new
	end
	def create
		
	end
	def show
		@user = User.find(params[:id])
		#@points = User.points
		#or something simlar
		#needs to atleast get total points for now
	end
end
