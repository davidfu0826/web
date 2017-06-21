class SabbaticalOfficer < ApplicationRecord
  acts_as_list
  attr_accessor(:remove_image)

  validates(:name, :role_sv, :role_en, :email, :phone, presence: true)
  mount_uploader(:image, ImageUploader)
  translates(:role, :description)

  scope(:by_position, -> { order(position: :asc) })

  def thumb
    image.thumb.url if image.present?
  end
end
