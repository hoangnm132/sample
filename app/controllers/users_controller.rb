class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]
    return if @user
    flash[:error] = t (".notfound")
    redirect_to root_path
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @user = User.find_by id: params[:id]
  end

  def update
    @user = User.find_by id: params[:id]
    if @user.update(user_params)
      flash[:success] = t ".successed"
      redirect_to @user
    else
      render "edit"
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def admin_user
    redirect_to root_url  unless current_user.admin?
  end

  def destroy
    User.find_by(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "please_login"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find_by id: params[:id]
    unless @user == current_user
      redirect_to root_url
      flash[:danger] = t "not_permited"
    end
  end
end
