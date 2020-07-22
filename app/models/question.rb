class Question < ApplicationRecord
  belongs_to :post
  validates :content, presence: true, length: { maximum: 255}
  #validates :answer_id
end
