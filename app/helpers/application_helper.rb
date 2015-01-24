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

  def image_link(image)
    edit_button   = "<a href='/images/#{image.id}/edit' class='btn btn-default'>#{t(:edit)}</a>"
    delete_button = "<a href='/images/#{image.id}' class='btn btn-danger' data-method='delete' rel='nofollow'>#{t(:destroy)}</a>"
    link_to image.url,
      data: {
        toggle: "lightbox",
        gallery: "images",
        parent: ".gallery-parent",
        title: image.title,
        footer: (edit_button + delete_button)
      } do
        (image_tag image.image.thumb('160x160#').url) +
        content_tag(:div, image.title, class: 'img-title')
    end
  end

  def banner_image
    # Get banner url
    a_name = controller.action_name
    c_name = controller.controller_name
    if a_name == 'show' && @page.present? && @page.image.present?
      url = @page.image.url
    elsif c_name == 'events' && a_name == 'index' && Settings[:events_cover_image]
      url = Image.find(Settings[:events_cover_image]).url
    elsif c_name == 'posts' && a_name == 'index'
      url = '/assets/cover.jpg'
    else
      url = nil
    end
    # Insert banner
    if url
      content_tag :div, class: 'banner-wrapper' do
        content_tag(:img, '', src: "/assets/white_stand_#{I18n.locale}.svg", id: 'logo') +
        content_tag(:img, '', src: url, id: 'banner', class: 'img-responsive center-block')
      end
    else
      content_tag :div, '', class: 'banner-wrapper'
    end
  end

  def nav_item_title_link(nav_item)
    if nav_item.page?
      link_to nav_item.page.title, nav_item.page
    elsif nav_item.link?
      link_to nav_item.title, nav_item.link
    else
      nav_item.title
    end
  end

  def study_week(week)
    if week.between?    36, 44 #LP 1
      week - 35
    elsif week.between? 45, 51 #LP 2
      week - 44
    elsif week.between? 4,  12 #LP 3
      week - 3
    elsif week.between? 13, 24 #LP 4
      week - 12
    else
      false
    end
  end

  def form_heading(action, model)
    content_tag :div, class: 'page-header' do
      content_tag :h1 do
        t("helpers.submit.#{action.to_s}", model: t("activerecord.models.#{model.to_s.underscore}").downcase)
      end
    end
  end
end
