class Upload < ApplicationRecord
  include Filterable
  dragonfly_accessor(:file) # to be removed

  mount_uploader(:pdf, DocumentUploader)
  validates(:pdf, presence: true)

  scope(:by_updated, -> { order(updated_at: :desc) })

  before_validation do
    self.file_name = sanitize_filename(file_name)
  end

  def sanitize_filename(filename)
    return if filename.nil?

    # Split the name when finding a period which is preceded by some
    # character, and is followed by some character other than a period,
    # if there is no following period that is followed by something
    # other than a period (yeah, confusing, I know)
    fn = filename.split(/(?<=.)\.(?=[^.])(?!.*\.[^.])/m)

    # We now have one or two parts (depending on whether we could find
    # a suitable period). For each of these parts, replace any unwanted
    # sequence of characters with an underscore
    fn.map! { |s| s.gsub(/[^a-z0-9\-]+/i, '_') }

    # Finally, join the parts with a period and return the result
    fn.join('.')
  end

  def file_type
    name.split('.').last.upcase
  end

  def name
    file_name || pdf_identifier
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def view
    pdf.try(:url)
  end
end
