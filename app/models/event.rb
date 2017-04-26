# Describes an event planned by the Union.
class Event < ActiveRecord::Base
  TZID = 'Europe/Stockholm'.freeze
  include Filterable
  include LocaleContent
  include Tagable # includes relationsships and tags-scope

  translates :title, :description

  validates :title_sv, :title_en, :start_time, :end_time, presence: true
  validate :end_time_after_start_time

  scope :by_start, -> { order(start_time: :asc) }
  scope :upcoming, (lambda do
    where('end_time > :current', current: Time.current).by_start
  end)

  def week
    start_time.to_date.cweek
  end

  def month
    start_time.beginning_of_month
  end

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank? || start_time < end_time
    errors.add(:end_time, I18n.t('errors.end_time_after_start_time'))
  end
end
