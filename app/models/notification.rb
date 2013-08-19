class Notification < ModelThatBelongsToUser
  belongs_to :user
  belongs_to :customer

  scope :pending, -> { where(ready: false) }
  scope :sent, -> { where(Notification.arel_table[:sent_at].not_eq(nil))}

  validates_length_of :message, :maximum => 160
end
