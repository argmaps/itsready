class Customer < ModelThatBelongsToUser
  belongs_to :user
  has_many :notifications

  validates_presence_of :first_name, :last_name, :country_code, :phone

  def full_name
    first_name + ' ' + last_name
  end
end
