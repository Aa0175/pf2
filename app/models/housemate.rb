class Housemate < ApplicationRecord
  has_many :user_housemates
  has_many :users, through: :user_housemates
end
