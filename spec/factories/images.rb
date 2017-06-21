FactoryGirl.define do
  factory :image do
    file { generate(:image_file) }
  end
end
