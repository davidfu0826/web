module ApplicationHelper
  def flash_class(level)
    case level
      when "notice" then "alert alert-info alert-dismissable"
      when "success" then "alert alert-success alert-dismissable"
      when "error" then "alert alert-danger"
      when "alert" then "alert alert-warning"
    end
  end

  def pagedown_input(object_name, method, options = {})
      button_bar = content_tag(:div, '', id: "wmd-button-bar-content")
      options.merge!(class: "form-control wmd-input", id: "wmd-input-content")
      content = text_area(object_name, method, options )
      preview = content_tag(:div, content_tag(:div, '', id: "wmd-preview-content"), class: "well")
      content_tag(:div, ( button_bar + content + preview ))
  end
end
