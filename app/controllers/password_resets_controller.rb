class PasswordResetsController < ApplicationController
  before_action :get_user, :valid_user, :check_expiration only: %i(edit update)

  def new; end

  def edit; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t("email_sent_for_password_reset")
      redirect_to root_url
    else
      flash.now[:danger] = t("email_not_found")
      render :new
    end
  end

  private
    def get_user
      @user = User.find_by(email: params[:email])
      return if @user
        redirect_to root_path
        flash[:error] = t("user_not_found")
    end

    def valid_user
      return if (@user&activated?&authenticated?(:reset, params[:id]))
      redirect_to root_url
    end

    def update
      if params[:user][:password].empty?
        @user.errors.add(:password,t("cant_be_empty"))
        render :edit
      elsif @user.update_attributes(user_params)
        log_in @user
        flash[:success] = t("password_has_been_reset")
        redirect_to @user
      else
        render :edit
    end

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def check_expiration
      return unless @user.password_reset_expired?
      flash[:danger] = t("password_reset_expired")
    end
end
