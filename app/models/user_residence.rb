class UserResidence < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :residence, optional: true
end
