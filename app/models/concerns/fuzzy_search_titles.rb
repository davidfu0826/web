module FuzzySearchTitles
  extend ActiveSupport::Concern

  included do
    scope :search, (lambda do |search|
      if I18n.locale == :sv
        ids = find_by_fuzzy_title_sv(search).map(&:id)
      else
        ids = find_by_fuzzy_title_en(search).map(&:id)
      end
      ids << joins(:tags).where("lower(tags.title) LIKE :search_param",
                                search_param: search.downcase).pluck(:id)
      where(id: ids.flatten)
    end)
  end
end
