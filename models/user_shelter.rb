class User_shelter < ActiveRecord::Base
  belongs_to :user
  belongs_to :shelter

  validates :user_id, presence: true
  validates :shelter_id, presence: true
end
