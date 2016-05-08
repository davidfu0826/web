FactoryGirl.define do
  factory :user do
    # Skip random password callback
    after(:build) { |obj| obj.class.skip_callback(:validation, :before) }

    email
    password 'testtest'
    name

    trait :admin do
      role 'admin'
    end

    trait :editor do
      role 'editor'
    end

    trait 'events' do
      role 'events'
    end

    trait :with_data do
      phonenumber
      locale 'sv'
    end
  end
end
