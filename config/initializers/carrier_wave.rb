#CarrierWave.configure do |config|
  #config.storage = :grid_fs
  #config.root = Rails.root.join('tmp')
  #config.cache_dir = "uploads"
  #config.grid_fs_access_url = '/uploads/'
#end

if Rails.env.production?
	CarrierWave.configure do |config|
		config.fog_credentials = {
			provider: "AWS",
			aws_access_key_id: ENV['S3_ACCESS_KEY'],
			aws_secret_key_id: ENV['S3_SECRET_KEY']
		}

		config.fog_directory = ENV['S3_BUCKET']
	end
end