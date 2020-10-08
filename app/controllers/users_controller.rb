class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show new create)
  before_action :load_users, only: %i(edit show update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.page(params[:page]).per Settings.pages_default
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      log_in @user
      flash[:success] = t ".welcome"
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = t ".please_check_email"
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
    @users = User.page(params[:page]).per Settings.pages_default
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".deleted"
      redirect_to users_url
    else
      flash[:error] = t ".delete_failed"
      redirect_to users_url
    end
  end

   def following
    @title = "Following"
    @user  = User.find_by(params[:id])
    @users = @user.following.page(params[:page]).per Settings.pages_default
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find_by(params[:id])
    @users = @user.followers.page(params[:page]).per Settings.pages_default
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def load_users
    @user = User.find_by id: params[:id]
    return if @user

    redirect_to root_url
  end

  def correct_user
    @user = User.find_by id: params[:id]
    return if @user == current_user

    redirect_to root_url
    flash[:danger] = t "not_permited"
  end
end
