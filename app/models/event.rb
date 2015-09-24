class Event < ActiveRecord::Base
  include Filterable
  include Tagable
  include FuzzySearchTitles

  validates :title_sv, presence: true
  validates :title_en, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_time_after_start_time

  before_validation(on: [:create, :update]) do
    taggings.each do |t|
      t.taggable = self
    end
  end
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  scope :with_tag, -> (tag_id) { joins(:tags).where('tags.id' => tag_id) }
  scope :upcoming, -> { where('end_time > :current', current: Time.current).order(start_time: :asc) }

  translates :title, :description
  fuzzily_searchable :title_en, :title_sv

  def day
    start_time.strftime('%e')
  end

  def short_month
    start_time.strftime('%B')[0, 3]
  end

  def status_text
    now = Time.current
    if start_time > now # Event is in the future
      if end_time > now # Event is inte the past, else Event is in the present
        I18n.t('events.status.has_ended')
      else
        I18n.t('events.status.ongoing')
      end
    else
      I18n.t('events.status.has_not_started_yet')
    end
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
