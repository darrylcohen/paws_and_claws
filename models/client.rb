class Client < ActiveRecord::Base
  belongs_to :shelter
  has_many :animals, dependent: :destroy #:restrict_with_error #
  #client.errors.full_messages
end
