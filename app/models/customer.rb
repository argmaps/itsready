class Customer < ModelThatBelongsToUser
  belongs_to :user
  has_many :notifications

  validates_presence_of :first_name, :last_name, :phone

  def full_name
    first_name + ' ' + last_name
  end

  def full_phone
    user.country_code.to_s + phone.to_s
  end
end
