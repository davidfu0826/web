module Markdown
  extend ActiveSupport::Concern

  $redcarpet = Redcarpet::Markdown.new(Redcarpet::Render::HTML)

  module ClassMethods
    def markdown(field)
      define_method("#{field}_html") do
        $redcarpet.render(read_attribute(field)).html_safe
      end
    end
  end
end
