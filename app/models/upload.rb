class Upload < ActiveRecord::Base
  include Filterable

  dragonfly_accessor :file
  delegate  :url, to: :file
  validates :file, presence: true

  fuzzily_searchable :file_name

  scope :search, ->(search) { where(id: find_by_fuzzy_file_name(search)) }
  scope :by_updated, -> { order(updated_at: :desc) }

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
    file_name.split('.').last.upcase
  end

  def to_param
    "#{id}-#{file_name.parameterize}"
  end

  def view
    if ENV['AWS']
      file.remote_url(scheme: 'https')
    else
      file.path
    end
  end
end
