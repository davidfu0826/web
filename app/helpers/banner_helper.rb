module BannerHelper

  def banner_image
    action = decide_banner(controller.action_name, controller.controller_name)
    url = get_url(action)
    get_banner(url, action)
  end

  private

  def decide_banner(action, controller)
    # If we are viewing a page with an image
    return :page_show if @page.try(:image).present? && action == 'show'

    # Event index
    if Settings[:events_cover_image] && controller == 'events' && action == 'index'
      return :event_index
    end

    # Posts index
    return :other unless controller == 'posts' && action == 'index'

    # Use carousel if active
    if Settings[:promoted_pages].present? && Settings[:promoted_pages].any?
      :homepage_carousel
    # Or the plain cover image
    else
      :homepage
    end
  end

  def get_url(action)
    case action
    when :page_show
      @page.image.image.thumb('1440x380#').url
    when :event_index
      Image.find(Settings[:events_cover_image]).image.thumb('1440x380#').url
    when :homepage
      'cover.jpg'
    else
      return nil
    end
  end

  def get_banner(url, action)
    if action == :homepage_carousel
      return render(
        'banner_carousel',
        pages: Page.includes(:image).find(Settings[:promoted_pages])
      )
    end

    if url
      content_tag :div, class: 'banner-wrapper' do
        image_tag("white_stand_#{I18n.locale}.svg", id: 'logo', size: '440x240') +
          image_tag(url, id: 'banner', class: 'img-responsive center-block', size: '1440x380')
      end
    else
      content_tag :div, '', class: 'banner-wrapper'
    end
  end
end
