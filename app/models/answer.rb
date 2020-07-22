class Answer < ApplicationRecord
  validates :content, presence: true, length: { maximum: 255}
  has_many :questions, through: :qa_relationships, dependent: :destroy
  has_many :qa_relationships


  # #必ずanswerかquestion_idがあるように設定
  # validates :question_or_answer, presence: true
  #
  # private
  #   def question_or_answer
  #     question_id.presence or answer_id.presence
  #   end
end
