class Post < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  validates :title,     presence: true, length: { maximum: 255}
  validates :user_id,   presence: true
  default_scope -> { order(created_at: :desc) }
end
