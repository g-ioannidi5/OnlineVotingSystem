json.array!(@access_codes) do |access_code|
  json.extract! access_code, :id, :code, :valid_until, :lecturer_id, :subject_id
  json.url access_code_url(access_code, format: :json)
end
