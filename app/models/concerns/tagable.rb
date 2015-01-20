module Tagable
  extend ActiveSupport::Concern

  module ClassMethods
    def create_with_tags(resource_params, tag_params)
      resource = self.new
      begin
        resource.update(resource_params)
        self.transaction do
          resource.tags = tag_params.split(",").map do |tag_title|
            Tag.find_or_create_by(title: tag_title)
          end
          resource.save!
        end
      rescue ActiveRecord::RecordInvalid
        # Could not save resource
      end
      resource
    end
  end

  def update_with_tags(resource_params, tag_params)
    begin
      self.transaction do
        self.update(resource_params)
        self.tags = tag_params.split(",").map do |tag_title|
          Tag.find_or_create_by(title: tag_title)
        end
        self.save!
      end
    rescue ActiveRecord::RecordInvalid
      false
    end
  end
end
