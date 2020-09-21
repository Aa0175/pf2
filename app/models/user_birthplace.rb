class UserBirthplace < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :birthplace, optional: true
end
