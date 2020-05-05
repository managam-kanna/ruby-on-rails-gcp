project_id = "ruby-on-rails-gcp"

require "google/cloud/storage"

# If you don't specify credentials when constructing the client, the client
# library will look for credentials in the environment.
storage = Google::Cloud::Storage.new project: project_id

# Make an authenticated API request
storage.buckets.each do |bucket|
  puts bucket.name
end
