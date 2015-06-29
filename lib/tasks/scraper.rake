namespace :scraper do
  desc "Fetch Indeed Posts from 3Taps"
  task scrape: :environment do
  	require 'open-uri'
		require 'json'

		# Set API token and URL
		auth_token = "5a005e04b6d10b7896d606bb4c1a9c5a"
		polling_url = "http://polling.3taps.com/poll"

		# Grap data untill update
		loop do

			# Specify request parameters
			params = {
				auth_token: auth_token,
				anchor: Anchor.first.value,
				source: "INDEE",
				category_group: "JJJJ",
				retvals: "location,external_url,heading,body,timestamp,annotations"
			}

			# Prepare API request
			uri = URI.parse(polling_url)
			uri.query = URI.encode_www_form(params)

			# Submit request
			result = JSON.parse(open(uri).read)

			# Display result to screen
			# puts result['postings'].first["location"]["state"]
			# puts JSON.pretty_generate result['postings'].first["heading"]
			puts JSON.pretty_generate result['postings']

			# Store result in database
			result["postings"].each do |posting|

				# Create new Post
				@job = Job.new
				@job.heading = posting["heading"]
				@job.body = posting["body"]
				@job.external_url = posting["external_url"]
				@job.timestamp = posting["timestamp"]
				@job.location = posting["location"]["formatted_address"]
				@job.state = posting["location"]["state"]
				@job.city = posting["location"]["city"]
				@job.country = posting["location"]["country"]
					# @job.country = posting["location"]["country"] if posting["location"]["country"].present?

				# Save Post
				@job.save
			end
			Anchor.first.update(value: result["anchor"])
			puts Anchor.first.value
			break if result["postings"].empty?
		end
  end

  desc "Destroy all Jobs Post"
  task destroy_all_jobs: :environment do
  	Job.destroy_all
  end

end
