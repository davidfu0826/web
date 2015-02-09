class Upload < ActiveRecord::Base
  include Filterable

  dragonfly_accessor  :file
  delegate  :url, to: :file
  validates :file, presence: true

  scope :search, -> (search) {
    where("lower(file_name) LIKE :search_param", search_param: search.downcase)
  }

  def file_type
    file_name.split('.').last.upcase
  end
end
