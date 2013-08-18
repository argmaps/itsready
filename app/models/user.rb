class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :notifications
  has_many :customers

  validates_presence_of :email, :password, :company

  def self.current
    RequestStore.store[:user]
  end

  def self.current=(user)
    RequestStore.store[:user] = user
  end
end
