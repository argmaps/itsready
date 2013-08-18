class Notification < ModelThatBelongsToUser
  belongs_to :user
  belongs_to :customer

  validates_length_of :message, :maximum => 160
end
