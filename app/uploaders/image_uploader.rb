# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base
      .helpers
      .asset_path([version_name, "course_default.png"].compact.join("_"))
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
