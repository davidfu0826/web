class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  if ENV['AWS']
    storage :aws
  else
    storage :file
  end

  def store_dir
    "#{model.class.name.pluralize.downcase}/#{model.id}"
  end

  def cache_dir
    "#{Rails.root}/tmp/images"
  end

  process :fix_exif_rotation

  # Resizes to width 1680px (if the image is larger)
  version :large do
    process resize_to_fit: [1680, 10_000]
  end

  # Creates a thumbnail version
  version :thumb do
    process resize_to_fill: [350, 350]
  end

  def fix_exif_rotation
    manipulate! do |img|
      img.auto_orient
      img = yield(img) if block_given?
      img
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
