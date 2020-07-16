json.extract! question, :id, :post_id, :answer_id, :content, :created_at, :updated_at
json.url question_url(question, format: :json)
