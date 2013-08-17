class Notification < ModelThatBelongsToUser
  belongs_to :user
  belongs_to :customer
end
