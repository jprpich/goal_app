class UsersController < ApplicationController
  def index
    render :index
  end


  def show
    @user = User.find_by(id: params[:id])
    if @user
      render :show
    else
      flash[:errors] = ['user does not exist']
      redirect_to users_url
    end
  end

  def new
    render :new
  end


  def create
    @user = User.new(user_params)
    if @user.save
      log_in!
      redirect_to user_url(@user)
    else
      flash[:errors] = ['invalid information']
      render :new
    end
  end



  private
    def user_params
      params.require(:user).permit(:username, :password)
    end

end