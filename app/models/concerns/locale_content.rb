module LocaleContent
  extend ActiveSupport::Concern

  def locale_content?(locale)
    return true if new_record?

    case locale
    when :sv
      content_sv.blank? && title_sv.blank?
    when :en
      content_en.blank? && title_en.blank?
    else
      false
    end
  end
end
