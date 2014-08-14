class Event < ActiveRecord::Base
  validates :title, presence: true
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
  scope :with_tag, -> (tag) { joins(:tags).where( 'tags.id' => tag.id ) }
  scope :search, -> (string) { where(["lower(title) LIKE ?", "%#{string}%"]) }

  scope :upcoming, -> { where(["start_time > ?", Time.now]).order(:start_time) }

  translates :title, :description

  def end_time_after_start_time
    if end_time.present? and start_time.present?
      errors.add(:end_time, I18n.t('.end_time_after_start_time')) if end_time < start_time
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

  def day
    start_time.strftime("%e")
  end

  def short_month
    start_time.strftime("%B")[0,3]
  end

  def status_text
    now = Time.now
    if start_time > now
      if end_time > now
        I18n.t('events.status.has_ended')
      else
        I18n.t('events.status.ongoing')
      end
    else
      I18n.t('events.status.has_not_started_yet')
    end
  end
end
