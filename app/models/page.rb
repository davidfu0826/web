class Page < ActiveRecord::Base
  include Markdown
  include AutoHtml

  validates :title, presence: true
  validates :slug, presence: true
  validates :content, presence: true
  # slug får inte vara ett reserverat namn typ users osv

  translates :title, :content

  has_one :nav_item
  belongs_to :user

  #markdown :content


  def content_html
    auto_html self.content do
      html_escape
      image
      youtube(:width => 400, :height => 250, :autoplay => true)
      link :target => "_blank", :rel => "nofollow"
      redcarpet
      simple_format
    end
  end

  def to_param
    slug
  end
end
