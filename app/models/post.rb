class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true

  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings

  translates :title, :content
end
