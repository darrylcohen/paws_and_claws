class Shelter < ActiveRecord::Base
  has_many :user_shelters
  has_many :animals
end
