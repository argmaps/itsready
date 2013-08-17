class HomeController < ApplicationController
  skip_before_filter :require_login

  def index
    respond_to do |format|
      format.html do
        redirect_to user_notifications_path(current_user) if current_user
      end
    end
  end
end
