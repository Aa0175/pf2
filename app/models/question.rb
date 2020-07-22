class Question < ApplicationRecord
  belongs_to :post
  has_many :answers, through: :qa_relationships, dependent: :destroy
  has_many :qa_relationships
  accepts_nested_attributes_for :qa_relationships, allow_destroy: true
  validates :content, presence: true, length: { maximum: 255}
  #validates :answer_id
end
