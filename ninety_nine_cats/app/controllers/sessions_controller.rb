class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
   
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
   
    if @user
      session[:session_token] = @user.reset_session_token!
      redirect_to cats_url
    else
      flash.now[:errors] = ['Wrong Username and/or Password']
      @user = User.new(username: params[:user][:username])
      render :new
    end
  end 

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end 

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end