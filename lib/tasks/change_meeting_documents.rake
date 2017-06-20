namespace :meeting_documents do
  desc 'Iterates through all meeting documents and moves file from document to own field.'
  task(to_own_field: :environment) do
    already_set = []
    failed = []
    MeetingDocument.includes(:document).find_each do |md|
      begin
        if md.file_sv.present? && md.file_en.present?
          already_set << md.id
          next
        end
        if ENV['AWS']
          md.remote_file_sv_url = md.document.file_sv.url
          md.remote_file_en_url = md.document.file_en.url
        else
          md.file_sv = File.open(md.document.file_sv.path)
          md.file_en = File.open(md.document.file_en.path)
        end
        md.save!
      rescue => error
        failed << md.id
        puts "#{md.id} : #{error}"
      end
    end

    if failed.any?
      puts "These id's failed: "
      puts failed
    end

    if already_set.any?
      puts "These id's were already set: "
      puts already_set
    end
  end
end
