class ModelThatBelongsToUser < ActiveRecord::Base
  self.abstract_class = true

  belongs_to :user

  validates_presence_of :user, :message => 'is required'
  before_validation :set_user_to_current_user


  protected

  def set_user_to_current_user
    return if user.present?
    self.user = User.current
  end

end
