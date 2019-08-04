class StaticPageController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.page(params[:page]).per Settings.pages_default
    end
  end

  def help; end

  def about; end

  def contact; end

end
