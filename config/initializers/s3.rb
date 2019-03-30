CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV["id_s3"],
      :aws_secret_access_key  => ENV["key_s3"],
      :region                 => 'us-west-1'
  }
  config.fog_directory  = ENV["name_s3"]
  config.fog_public     = true
end
