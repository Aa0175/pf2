class UserSex < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :sex, optional: true
end
