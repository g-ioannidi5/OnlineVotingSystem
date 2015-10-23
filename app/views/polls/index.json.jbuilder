json.array!(@polls) do |poll|
  json.extract! poll, :id, :name, :lecturer_id, :access_code, :access_code_lecturer, :subject_id
  json.url poll_url(poll, format: :json)
end
