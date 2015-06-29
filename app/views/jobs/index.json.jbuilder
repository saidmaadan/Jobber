json.array!(@jobs) do |job|
  json.extract! job, :id, :heading, :body, :timestamp, :external_url, :location
  json.url job_url(job, format: :json)
end
