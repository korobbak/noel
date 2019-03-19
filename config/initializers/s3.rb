CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => "AKIAJDURWEVFDJKU4C5Q",
      :aws_secret_access_key  => "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",
      :region                 => 'us-west-1'
  }
  config.fog_directory  = "noelweb"
  config.fog_public     = true
end
