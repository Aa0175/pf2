class Answer < ApplicationRecord
  validates :content, presence: true, length: { maximum: 255}
  #必ずanswerかquestion_idがあるように設定したい
  validates :question_or_answer, presence: true

  private
    def question_or_answer
      question_id.presence or answer_id.presence
    end
end
