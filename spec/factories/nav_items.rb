FactoryBot.define do
  factory(:nav_item) do
    title_sv
    title_en

    trait :menu do
      nav_item_type 'menu'
    end

    trait :page do
      nav_item_type 'page'
      page
    end

    trait :link do
      nav_item_type 'link'
      link
    end
  end
end
