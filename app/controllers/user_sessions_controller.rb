class UserSessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success]= "Thanks for logging!"
      redirect_to todo_lists_path
    else
      render :new
      flash[:error]="Please check your email and password!"
    end
  end
end
