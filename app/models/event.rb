class Event < ActiveRecord::Base
  include Filterable
  include Tagable
  include FuzzySearchTitles
  include LocaleContent

  validates :title_sv, presence: true
  validates :title_en, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_time_after_start_time
  validates :description_sv, length: { maximum: 255 }
  validates :description_en, length: { maximum: 255 }

  before_validation(on: [:create, :update]) do
    taggings.each do |t|
      t.taggable = self
    end
  end
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  scope :upcoming, -> { where('end_time > :current', current: Time.current).order(start_time: :asc) }

  translates :title, :description
  fuzzily_searchable :title_en, :title_sv

  def day
    start_time.strftime('%e')
  end

  def short_month
    start_time.strftime('%B')[0, 3]
  end

  def to_ics
    event = Icalendar::Event.new
    event.dtstart = start_time
    event.dtend = end_time
    event.summary = self.title
    event.description = self.description
    event.ip_class = "PUBLIC"
    event.created = self.created_at
    event.last_modified = self.updated_at
    event.uid = event.url = "#{PUBLIC_URL}events/#{self.id}"
    event
  end

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if end_time < start_time
      errors.add(:end_time, I18n.t('errors.end_time_after_start_time'))
    end
  end
end
