class Event < ActiveRecord::Base
  TZID = 'Europe/Stockholm'.freeze
  include Filterable
  include Tagable
  include LocaleContent

  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  translates :title, :description

  validates :title_sv, :title_en, :start_time, :end_time, presence: true
  validates :description_sv, :description_en, length: { maximum: 255 }
  validate :end_time_after_start_time

  before_validation(on: [:create, :update]) do
    taggings.each do |t|
      t.taggable = self
    end
  end

  scope :by_start, -> { order(start_time: :asc) }
  scope :upcoming, -> { where('end_time > :current', current: Time.current).by_start }

  def day
    start_time.strftime('%e')
  end

  def week
    start_time.to_date.cweek
  end

  def month
    start_time.beginning_of_month
  end

  def short_month
    start_time.strftime('%B')[0, 3]
  end

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if end_time < start_time
      errors.add(:end_time, I18n.t('errors.end_time_after_start_time'))
    end
  end
end
