module LocalizationHelper
  def localized(date, format: :default)
    if date.present?
      l(date, format: format)
    end
  end
end
