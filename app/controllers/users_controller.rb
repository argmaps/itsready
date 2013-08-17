class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]

  def create
    p = permitted_params
    @user = User.new({
      email: p[:email],
      password: p[:password],
      company: p[:company]
    })

    respond_to do |format|
      if @user.save
        auto_login(@user, true)

        format.json { render :json, status: :ok }
        format.html { redirect_to user_notifications_path(current_user) }
      else
        format.json { render :json => {error: "invalid username-password combination."}, :status => :unprocessable_entity }
        format.html { redirect_to :action => :new }
      end
    end
  end
end
