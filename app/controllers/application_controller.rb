class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :require_login

  def permitted_params
    @permitted_params ||= PermittedParams.new(params, current_user)
    @permitted_params.send(singular_model_name)
  end

  def singular_model_name
    self.class.to_s.gsub('Controller', '').underscore.singularize.downcase
  end

  def set_current_user
    User.current = current_user
  end
end
