json.array!(@subjects) do |subject|
  json.extract! subject, :id, :code, :title, :lecturer_id
  json.url subject_url(subject, format: :json)
end
