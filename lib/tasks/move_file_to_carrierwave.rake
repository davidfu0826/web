namespace :carrierwave do
  desc 'Will iterate through all images, moving the file from the file from Dragonfly (and Lunicores S3) to a Carrierwave field in each post (and TLTHs S3).'
  task(images: :environment) do
    images = Image.all
    failed = []
    images.each do |i|
      begin
        if i.file.present?
          failed << i.id
          next
        end
        if ENV['AWS']
          i.remote_file_url = i.image.remote_url
        else
          i.file = File.open(i.image.path)
        end
        i.file_name = i.image_name
        i.save!
      rescue => error
        failed << i.id
        puts "#{i.id} : #{error}"
      end
    end

    if failed.any?
      puts "These id's failed: "
      puts failed
    end
  end

  task(uploads_to_image: :environment) do
    uploads = Upload.all
    image_types = ['jpeg', 'jpg', 'png', 'gif']
    failed = []
    uploads.each do |u|
      begin
        unless image_types.include? u.file_type.try(:downcase)
          failed << "#{u.id} - #{u.file_type}"
          next
        end
        unless u.image_id.nil?
          failed << "#{u.id} - already image #{u.image_id}"
          next
        end
        Upload.transaction do
          i = Image.new()
          if ENV['AWS']
            i.remote_file_url = u.file.remote_url
          else
            i.file = File.open(u.file.path)
          end
          i.save!
          i.update!(file_name: u.file_name)
          u.update!(image: i)
        end
      rescue => error
        failed "#{u.id} - #{error}"
      end
    end
    puts failed
  end

  task(add_to_upload: :environment) do
    already_moved = []
    failed = []
    Upload.all.each do |u|
      begin
        if u.pdf.present?
          already_moved << u.id
          next
        end
        if ENV['AWS']
          u.remote_pdf_url = u.file.remote_url
        else
          u.pdf = File.open(u.file.path)
        end
        u.save!
      rescue => error
        failed << u.id
        puts "#{u.id} : #{error}"
      end
    end

    if failed.any?
      puts "These id's failed: "
      puts failed
    end

    if already_moved.any?
      puts "These id's already moved: "
      puts already_moved
    end
  end
end
