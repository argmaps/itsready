class SessionsController < ApplicationController
  skip_before_filter :require_login

  def new
    @user = User.new
  end

  def create
    respond_to do |format|
      if @user = login(adapted_params[:email], adapted_params[:password], remember_me=true)
        format.json { render json: @user, :status => :ok }
        format.html { redirect_back_or_to(user_notifications_path(current_user)) }
      else
        error_msg = "Login failed. Please try again."
        format.json { render :json => {error: error_msg}, :status => :unprocessable_entity }
        format.html { flash.now['alert-error'] = error_msg; render :action => "new" }
      end
    end
  end

  def destroy
    logout
    flash[:notice] = "You are now signed out."
    redirect_to new_session_path
  end

  private
  def adapted_params
    params.require('/sessions').permit(:email, :password)
  end

end
