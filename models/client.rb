class Client < ActiveRecord::Base
  belongs_to :shelter
  has_many :animals
end
