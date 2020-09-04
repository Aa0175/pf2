class Post < ApplicationRecord
  belongs_to :user
  has_many :nodes, dependent: :destroy
  validates :title,     presence: true, length: { maximum: 255}
  validates :user_id,   presence: true
  default_scope -> { order(created_at: :desc) }
  mount_uploader :img, ImgUploader
end
