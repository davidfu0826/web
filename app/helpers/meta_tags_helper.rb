module MetaTagsHelper
  def description(content)
    if content.present?
      sanitized = truncate(strip_tags(content), length: 155)
      set_meta_tags(description: sanitized,
                    twitter: { description: sanitized },
                    og: { description: sanitized })
      content
    end
  end

  def title(text)
    if text.present?
      set_meta_tags(title: text,
                    twitter: { title: text },
                    og: { title: text })
      text
    end
  end

  def meta_image(image)
    if image.present?
      url = image_url(image)
      set_meta_tags(image: url,
                    twitter: { image: url },
                    og: { image: url })
      image
    end
  end
end
