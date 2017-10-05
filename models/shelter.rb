class Shelter < ActiveRecord::Base
  has_many :user_shelters, dependent: :restrict_with_error
  has_many :animals, dependent: :restrict_with_error
  has_many :clients , dependent: :restrict_with_error # :destroy
end
