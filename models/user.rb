class User < ActiveRecord::Base
  has_secure_password
  has_many :plants
  has_many :comments

end