class Upload < ActiveRecord::Base
  include Filterable

  dragonfly_accessor  :file
  delegate  :url, to: :file
  validates :file, presence: true

  fuzzily_searchable :file_name

  scope :search, -> (search) {
    where(id: self.find_by_fuzzy_file_name(search).map(&:id))
  }

  def file_type
    file_name.split('.').last.upcase
  end
end
