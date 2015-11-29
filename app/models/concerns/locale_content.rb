module LocaleContent
  extend ActiveSupport::Concern

  def locale_content?(locale)
    return true if new_record?

    case locale
    when :sv
      self.class == Event ? description_sv.present? : content_sv.present?
    when :en
      self.class == Event ? description_en.present? : content_en.present?
    else
      false
    end
  end
end
