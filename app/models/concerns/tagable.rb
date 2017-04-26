# Includes relationships to tags and taggins as well as a scope used for filtering.
module Tagable
  extend ActiveSupport::Concern

  included do
    has_many :taggings, as: :taggable
    has_many :tags, through: :taggings

    scope :tags, (lambda do |tag_ids|
      tag_ids.reject!(&:empty?)
      joins(:tags).where(tags: { id: tag_ids }) unless tag_ids.empty?
    end)
  end
end
