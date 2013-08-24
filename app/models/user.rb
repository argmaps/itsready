class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :notifications
  has_many :customers

  validates_presence_of :email, :password, :company, :country

  def self.current
    RequestStore.store[:user]
  end

  def self.current=(user)
    RequestStore.store[:user] = user
  end

  def country_code
    c = Country.find_country_by_alpha2(country)
    c.country_code
  end
end
