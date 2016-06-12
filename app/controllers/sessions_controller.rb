class SessionsController < ApplicationController
	def create
		@user = Account.authenticate(params[:email], params[:password])
		if @user
			flash[:notice] = "You've been logged in."
			session[:user_id] = @user.id
			redirect_to :controller => "home", :action => "index"
		else
			flash[:alert] = "There was a problem logging you in."
			redirect_to login_path
		end
	end

	def logout
		session[:user_id] = nil
		flash[:message] = 'Logouted out'
		redirect_to logout_path
	end

	def forget_password
		if request.post?
			user = Account.find_by_email(params[:user][:email])

			if user and user.send_new_password
				flash[:message] = "A new password has been send by email"
				redirect_to action: "login"
			else
				flash[:warning] = "Couldn't send password"
			end
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "You've been logged out successfully."
		redirect_to "/"
	end
end
