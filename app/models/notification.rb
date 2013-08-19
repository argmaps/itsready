class Notification < ModelThatBelongsToUser
  belongs_to :user
  belongs_to :customer

  scope :pending, -> { where(ready: false) }

  validates_length_of :message, :maximum => 160
end
