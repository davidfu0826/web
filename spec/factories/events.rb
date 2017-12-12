FactoryBot.define do
  factory :event do
    title_sv { FFaker::CheesyLingo.title }
    title_en { title_sv }
    start_time { 2.days.from_now }
    end_time { start_time + 12.hours }
    description_sv { FFaker::Lorem.sentences }
    description_en { FFaker::Lorem.sentences }

    trait :timestamps do
      created_at { Time.zone.now }
      updated_at { created_at }
    end
  end
end
