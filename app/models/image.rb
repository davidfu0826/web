class Image < ActiveRecord::Base
  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings

  dragonfly_accessor :image
end
