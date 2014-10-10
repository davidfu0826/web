class CharacterValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /[a-zA-ZåöäÅÄÖ\d]+/
      record.errors[attribute] << (options[:message] || I18n.t("errors.no_special_chars") )
    end
  end
end
