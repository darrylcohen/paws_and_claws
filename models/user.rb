class User < ActiveRecord::Base

  has_many :user_shelters
  has_secure_password


end
