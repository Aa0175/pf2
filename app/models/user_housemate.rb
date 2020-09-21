class UserHousemate < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :housemate, optional: true
end
