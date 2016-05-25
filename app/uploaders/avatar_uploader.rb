class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  version :thumbnail do
    resize_to_fit 50, 50
  end

  version :standard do
    resize_to_fit 150, 150
  end
end
