module DocumentHelper
  def document_categories
    res = []
    Document.categories.keys.sort.each do |c|
      res << [t("model.document.categories.#{c}"), c]
    end
    res
  end
end
