class AccountController < ApplicationController

	def list
		@user = Account.order(:email)
	end

	def destroy
		@user = Account.find(params[:id]).destroy
		redirect_to '/', notice: "User deleted."
	end

	def create
		@user = Account.new(user_params)
		if @user.save
			flash[:notice] = "Welcome to the site!"
			redirect_to "/"
		else
			flash[:alert] = "There was a problem creating your account. Please try again."
			redirect_to :back
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end
end
