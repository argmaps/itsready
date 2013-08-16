class PermittedParams < Struct.new(:params, :user)
  def user
    params.permit(user: user_params)
  end

  def user_params
    [
      :id,
      :email,
      :password,
      :user
    ]
  end
end
