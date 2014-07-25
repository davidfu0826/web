class Page < ActiveRecord::Base
  include AutoHtml
  include ApplicationHelper

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  validate :slug_not_reserved_name
  validates :content, presence: true

  translates :title, :content

  has_one :nav_item, dependent: :destroy
  has_and_belongs_to_many :contacts, class_name: 'User'
  has_many :contact_forms

  scope :orphans, -> { includes(:nav_item).where( :nav_items => { :page_id => nil } ) }

  def slug_not_reserved_name
    reserved_names = %(users events event_groups posts nav_items pages).split
    if reserved_names.include? slug
      errors.add(:slug, I18n.t('errors.slug_reserved'))
    end
  end

  def content_html
    filters
    auto_html self.content do
      redcarpet
      youtube(:width => '70%', :height => '400', :autoplay => false)
      podio_webforms
      #image_gallery
      simple_format
    end
  end

  def to_param
    slug
  end

  private

  def filters
    AutoHtml.add_filter(:podio_webforms) do |link|
      link.gsub(/https:\/\/podio\.com\/webforms\/([0-9]*)\/([0-9]*)(\/)?/) do |url|
        id = url.split('/').last
        %{<script src="#{url}.js"></script><script type="text/javascript">_podioWebForm.render("#{id}")</script>}
      end
    end
    AutoHtml.add_filter(:image_gallery) do |text|
      text.gsub(/!\{[\S+\s]+\}/) do |match|
        images = match.slice(2, match.length - 3 ).split
        #%{#{images}}
        image_gallery = image_gallery images
        %{#{image_gallery}}
      end
    end
  end
end
