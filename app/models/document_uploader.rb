class DocumentUploader < CarrierWave::Uploader::Base
  if ENV['AWS']
    storage :aws

    def store_dir
      "#{model.class.name.pluralize.downcase}/#{model.id}"
    end

    def cache_dir
      "#{Rails.root}/tmp/uploads"
    end
  else
    storage :file
  end

  def extension_white_list
    %w(pdf)
  end
end
