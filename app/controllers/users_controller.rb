class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :load_users, only: %i(edit show update delete)
  before_action :correct_user,  only: %i(edit update)
  before_action :admin_user, only: %i(destroy)

  def new
    @user = User.new
  end

  def show
    load_users
    return if @user
      flash[:error] = t (".notfound")
      redirect_to root_path
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      log_in @user
      flash[:success] = t ".welcome"
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = t".please_check_email"
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".successed"
      redirect_to @user
    else
      render :edit
    end
  end

  def index
     @users = User.all.page(params[:page]).per(5)
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = t ".deleted"
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def load_users
    @user = User.find_by id: params[:id]
  end

  def logged_in_user
    return if logged_in?
      store_location
      flash[:danger] = t "please_login"
      redirect_to login_url
    end
  end

  def correct_user
    load_users
    return if @user == current_user
      redirect_to root_url
      flash[:danger] = t "not_permited"
  end
end
