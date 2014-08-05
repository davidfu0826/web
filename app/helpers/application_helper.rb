module ApplicationHelper
  include AutoHtml
  def flash_class(level)
    case level
      when "notice" then "alert alert-info alert-dismissable"
      when "success" then "alert alert-success alert-dismissable"
      when "error" then "alert alert-danger"
      when "alert" then "alert alert-warning"
    end
  end

  def pagedown_input(object_name, method, options = {})
    options.merge!(class: "form-control wmd-input", id: "wmd-input-#{method.to_s}")
    button_bar = content_tag(:div, '', id: "wmd-button-bar-#{method.to_s}")
    content = text_area(object_name, method, options)
    preview = content_tag(:div, content_tag(:div, '', id: "wmd-preview-#{method.to_s}"), class: "well")
    content_tag(:div, ( button_bar + content + preview ))
  end

  def format_tweet(text)
    AutoHtml.add_filter(:twitter_user) do |text|
      text.gsub(/@([^\s]+)/) do |user|
        %{<a href="http://twitter.com/#{user}" class="hashtag" target="_blank">#{user}</a>}
      end
    end
    auto_html(text) do
      link
      hashtag
      twitter_user
    end
  end
end
