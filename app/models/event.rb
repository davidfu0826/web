class Event < ActiveRecord::Base
  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_time_after_start_time

  belongs_to :event_group

  scope :by_group, ->(group) { where event_group: group }

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
    #event.uid = event.url = "#{PUBLIC_URL}events/#{self.id}" #TODO: Rätt url
    event
  end

  def day
    start_time.strftime("%e")
  end

  def short_month
    start_time.strftime("%B")[0,3]
  end
end
