json.array!(@questions) do |question|
  json.extract! question, :id, :question, :answer1, :answer2, :answer3, :answer4, :answer5, :answer6, :poll_id, :lecturer_id, :access_code
  json.url question_url(question, format: :json)
end
