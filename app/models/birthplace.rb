class Birthplace < ApplicationRecord
  has_many :user_birthplaces
  has_many :users, through: :user_birthplaces
end
