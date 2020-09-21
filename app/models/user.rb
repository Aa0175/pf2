class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy

  has_many :user_sexes, dependent: :destroy
  has_many :sexes,        through: :user_sexes
  has_many :user_birthplaces, dependent: :destroy
  has_many :birthplaces, through: :user_birthplaces
  has_many :user_residences, dependent: :destroy
  has_many :residences,    through: :user_residences
  has_many :user_housemates, dependent: :destroy
  has_many :housemates,   through: :user_housemates

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6}, allow_nil: true

  mount_uploader :img, ImgUploader
end
