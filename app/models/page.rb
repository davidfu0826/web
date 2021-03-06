class Page < ApplicationRecord
  include LocaleContent

  validates(:title_sv, :title_en, presence: true, character: true)
  validates(:slug, presence: true,
                   uniqueness: { case_sensitive: false },
                   format: { with: /\A[a-z0-9-]+\z/ })
  validates :content, presence: true
  validate :slug_not_reserved_path

  translates :title
  translates :content

  has_one :nav_item, dependent: :destroy

  after_save { nav_item && nav_item.touch }

  has_and_belongs_to_many :contacts, class_name: 'User', touch: true
  has_many :contact_forms

  belongs_to :image, optional: true

  scope :orphans, (lambda do
    includes(:nav_item).where(nav_items: { page_id: nil })
  end)
  scope :with_image, (-> { where.not(image: nil) })

  before_validation do
    self.slug ||= title_en.parameterize
  end

  def slug_not_reserved_path
    return unless reserved_paths.include?(slug)
    errors.add(:slug, I18n.t('errors.slug_reserved'))
  end

  def to_param
    slug
  end

  def cover_image
    image.cover_image if image.present?
  end

  private

  def reserved_paths
    match_initial_path_segment = proc do |path|
      if (match = %r{^\/([^\/\(:]+)}.match(path))
        match[1]
      end
    end

    routes = Rails.application.routes.routes
    paths = routes.collect { |r| r.path.spec.to_s }
    paths.collect { |path| match_initial_path_segment.call(path) }.compact.uniq
  end
end
