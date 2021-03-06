module ApplicationHelper
  def flash_class(level)
    case level
    when "notice" then "alert alert-info alert-dismissable"
    when "success" then "alert alert-success alert-dismissable"
    when "error" then "alert alert-danger"
    when "alert" then "alert alert-warning"
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
    if week.between?    36, 44 # LP 1
      week - 35
    elsif week.between? 45, 51 # LP 2
      week - 44
    elsif week.between? 4,  12 # LP 3
      week - 3
    elsif week.between? 13, 24 # LP 4
      week - 12
    else
      false
    end
  end

  def form_heading(action, model)
    content_tag :div, class: 'page-header' do
      content_tag :h1 do
        t("helpers.submit.#{action}",
          model: t("activerecord.models.#{model.to_s.underscore}").downcase)
      end
    end
  end
end
