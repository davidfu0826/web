FactoryBot.define do
  factory :meeting do
    title { generate(:title_sv) }
    year { ["2017", "16/17", "2016", "15/16"].sample }
    kind { Meeting.kinds.keys.sample }
    sequence(:ranking) { |n| n }
    meeting_date { rand(6).days.ago }
  end
end
