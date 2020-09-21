class Residence < ApplicationRecord
  has_many :user_residences
  has_many :users, through: :user_residences
end
