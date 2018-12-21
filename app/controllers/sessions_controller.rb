class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    username = params[:user][:username]
    password = params[:user][:password]
    @user = User.find_by_credentials(username, password)
    if @user 
      log_in!
      redirect_to user_url(@user)
    else
      flash[:errors] = ['invalid information']
      render :new 
    end
  end


  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil 
    @user = nil
    render :new 
    
  end

end