class PermittedParams < Struct.new(:params, :user)
  def user
    params.require(:user).permit(user_params)
  end

  def user_params
    [
      :id,
      :email,
      :password,
      :company,
      :country
    ]
  end
end
