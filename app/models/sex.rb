class Sex < ApplicationRecord
  has_many :user_sexes
  has_many :users, through: :user_sexes
end
