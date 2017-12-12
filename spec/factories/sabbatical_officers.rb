FactoryBot.define do
  factory :sabbatical_officer do
    name
    description_sv { generate(:content_sv) }
    description_en { generate(:content_en) }
    role_sv { %w[Kårordförande Generalsekreterare Näringslivsansvarig].sample }
    role_en { %w[President Secretary Pedell].sample }
    sequence(:position) { |n| n }
    image { generate(:image_file) }
    email
    phone { generate(:phonenumber) }
  end
end
