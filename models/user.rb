class User < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :username
  validates_presence_of :password
  validates_presence_of :email
  has_many :events
end
